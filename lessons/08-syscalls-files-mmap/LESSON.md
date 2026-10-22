# Lesson 08 — Win32 File API, HANDLEs, VirtualAlloc

You have been calling `GetStdHandle`, `WriteFile`, and `ExitProcess` since lesson 00. This lesson makes the Microsoft x64 contract those imports demand explicit, shows you how failure is encoded as `FALSE`, `NULL`, or `INVALID_HANDLE_VALUE` plus `GetLastError`, and walks `CreateFileA`, `ReadFile`, `WriteFile`, `CloseHandle`, `SetFilePointer`, `SetFilePointerEx`, `VirtualAlloc`, `VirtualFree`, `CreateFileMappingA`, and `MapViewOfFile` without the C runtime. A Win32 call is not a magic word. It is a register-and-stack contract you honor.

Windows user-mode code does not issue a raw `syscall` for these services. Syscall numbers change between builds. You declare `EXTRN Name:PROC`, link `kernel32.lib`, and `call` through the Import Address Table.

## What this lesson asks of you

- Place arguments in RCX, RDX, R8, R9, and further arguments on the stack starting at `[rsp+32]`. Allocate 32 bytes of shadow space before every `call`. Read the return in RAX.
- Recognize `FALSE` (0), `NULL` (0), and `INVALID_HANDLE_VALUE` (−1), then call `GetLastError` for the thread's last error code.
- Call `CreateFileA` with path, access (`GENERIC_READ` / `GENERIC_WRITE`), share mode, security attributes, creation disposition (`CREATE_ALWAYS`, `OPEN_EXISTING`, `OPEN_ALWAYS`), attributes, and template, and keep the returned HANDLE.
- Pass that HANDLE to `ReadFile`, `WriteFile`, `SetFilePointer` or `SetFilePointerEx`, and `CloseHandle`.
- Allocate anonymous pages with `VirtualAlloc` and release them with `VirtualFree`. Map a file with `CreateFileMappingA` and `MapViewOfFile`.
- Call `GetCurrentProcessId` and `QueryPerformanceCounter` / `QueryPerformanceFrequency` as ordinary imports.

## The Microsoft x64 register protocol

A Win32 API call is an imported function, usually from `kernel32.dll`. The linker turns `call FunctionName` into an indirect call through the IAT. The implementation reads RCX/RDX/R8/R9 and the stack slots above shadow space, writes a return value into RAX, and returns to the instruction after your `call`.

| Register / slot | Role |
|-----------------|------|
| RCX | Argument 1 |
| RDX | Argument 2 |
| R8 | Argument 3 |
| R9 | Argument 4 |
| `[rsp+32]` | Argument 5 (first stack parameter, above shadow space) |
| `[rsp+40]` | Argument 6 |
| `[rsp+48]` | Argument 7 |
| RAX | Return (integer, pointer, HANDLE, or BOOL) |

The caller allocates **32 bytes of shadow space** (home space) at `[rsp]` through `[rsp+31]` before every `call`, even when the function takes fewer than four arguments. The callee may spill RCX/RDX/R8/R9 there.

**Volatile (caller-saved):** RAX, RCX, RDX, R8, R9, R10, R11, XMM0–XMM5.
**Nonvolatile (callee-saved):** RBX, RBP, RDI, RSI, R12–R15, XMM6–XMM15.

On Windows, RDI and RSI are **nonvolatile**. That is the opposite of the Linux System V ABI, where they are argument registers. If a returning procedure writes them, it must save and restore them.

| Function | Arg1 (RCX) | Arg2 (RDX) | Arg3 (R8) | Arg4 (R9) | Arg5+ (`[rsp+32]`…) |
|----------|------------|------------|-----------|-----------|---------------------|
| `CreateFileA` | path | access | share | security | disposition, attributes, template |
| `ReadFile` | handle | buffer | count | &read | overlapped |
| `WriteFile` | handle | buffer | count | &written | overlapped |
| `CloseHandle` | handle | — | — | — | — |
| `SetFilePointer` | handle | low distance | &high distance | whence | — |
| `SetFilePointerEx` | handle | 64-bit offset | &newpos | whence | — |
| `VirtualAlloc` | addr | size | type | protect | — |
| `VirtualFree` | addr | size | type | — | — |
| `CreateFileMappingA` | file | security | protect | size high | size low, name |
| `MapViewOfFile` | mapping | access | offset high | offset low | byte count |
| `GetLastError` | — | — | — | — | — |
| `GetCurrentProcessId` | — | — | — | — | — |
| `QueryPerformanceCounter` | &counter | — | — | — | — |
| `QueryPerformanceFrequency` | &freq | — | — | — | — |
| `ExitProcess` | exitCode | — | — | — | — |

Listings in this lesson declare imports with `EXTRN Name:PROC`. MASM also accepts `EXTERN`.

## Interpreting Win32 returns and GetLastError

Most file functions return a BOOL (nonzero = TRUE = success, 0 = FALSE = failure) or a HANDLE/pointer. On failure the error code is **not** in RAX. It sits in thread-local storage until you call `GetLastError`, which returns it in RAX (the listings then move EAX into ECX for `ExitProcess`).

| Function | Success | Failure |
|----------|---------|---------|
| `CreateFileA` | HANDLE ≠ −1 | `INVALID_HANDLE_VALUE` (−1, all bits 1) |
| `ReadFile`, `WriteFile`, `CloseHandle` | nonzero TRUE | 0 FALSE |
| `SetFilePointerEx` | nonzero TRUE | 0 FALSE |
| `SetFilePointer` | new low DWORD, or `INVALID_SET_FILE_POINTER` (`0FFFFFFFFh`) on failure | check `GetLastError` |
| `VirtualAlloc`, `CreateFileMappingA`, `MapViewOfFile` | nonzero address/handle | NULL (0) |
| `VirtualFree`, `UnmapViewOfFile` | nonzero TRUE | 0 FALSE |
| `QueryPerformanceCounter` / `QueryPerformanceFrequency` | nonzero TRUE | 0 FALSE |

`CreateFileA` failure is −1, not 0. `test rax, rax` / `jz` misses it: −1 is nonzero. Listing `13-open-missing-get-last-error` compares `rax` to −1, then calls `GetLastError` and exits with that code. The path is `C:\no\such\file.txt`, so the missing directory components produce **3** (`ERROR_PATH_NOT_FOUND`), not 2 (`ERROR_FILE_NOT_FOUND`). Listing `09-close-handle` shows the BOOL test: `test rax, rax` / `jz close_failed` after `CloseHandle`.

| Code | Name | Meaning |
|-----:|------|---------|
| 2 | `ERROR_FILE_NOT_FOUND` | File does not exist |
| 3 | `ERROR_PATH_NOT_FOUND` | Directory does not exist |
| 5 | `ERROR_ACCESS_DENIED` | Permission denied |
| 6 | `ERROR_INVALID_HANDLE` | HANDLE already closed or never valid |
| 32 | `ERROR_SHARING_VIOLATION` | Another process holds an incompatible share |
| 80 | `ERROR_FILE_EXISTS` | File already exists (`CREATE_NEW`) |

Windows splits “did it work?” (the return) from “which error?” (`GetLastError`). That lets a function return a HANDLE or a byte count without reserving a negative range.

## HANDLEs and the CreateFile–Write–Close cycle

A **HANDLE** is an opaque 64-bit kernel object identifier. You pass it to `ReadFile`, `WriteFile`, `SetFilePointer` / `SetFilePointerEx`, and `CloseHandle`. Three standard handles already exist for a console process; `GetStdHandle` returns them (lesson 00):

| Constant | Value | Use |
|----------|------:|-----|
| `STD_INPUT_HANDLE` | −10 | Keyboard, redirected file, or pipe |
| `STD_OUTPUT_HANDLE` | −11 | Console, redirected file, or pipe |
| `STD_ERROR_HANDLE` | −12 | Usually the console |

Those are not small integer file descriptors. Do not assume a new `CreateFileA` HANDLE is 3, or that HANDLE values recycle from the bottom.

### Opening and writing: `CreateFileA` + `WriteFile`

`CreateFileA` (ANSI path; `CreateFileW` is UTF-16) takes seven arguments:

1. `lpFileName` (RCX) — address of a NUL-terminated path
2. `dwDesiredAccess` (RDX) — `GENERIC_READ` (`80000000h`), `GENERIC_WRITE` (`40000000h`), or both (`0C0000000h`)
3. `dwShareMode` (R8) — 0 exclusive; `FILE_SHARE_READ` = 1; `FILE_SHARE_WRITE` = 2
4. `lpSecurityAttributes` (R9) — usually NULL (0)
5. `dwCreationDisposition` (`[rsp+32]`) — see table
6. `dwFlagsAndAttributes` (`[rsp+40]`) — `FILE_ATTRIBUTE_NORMAL` = `080h`
7. `hTemplateFile` (`[rsp+48]`) — usually NULL

| Disposition | Value | Meaning |
|-------------|------:|---------|
| `CREATE_NEW` | 1 | Create; fail if it exists |
| `CREATE_ALWAYS` | 2 | Create; truncate if it exists |
| `OPEN_EXISTING` | 3 | Open; fail if missing |
| `OPEN_ALWAYS` | 4 | Open; create if missing |
| `TRUNCATE_EXISTING` | 5 | Open and empty; fail if missing |

Windows file permission is an ACL, not a Unix mode such as 0644. For these listings, `FILE_ATTRIBUTE_NORMAL` is enough.

Listing `01-create-file-write` creates or truncates `test.txt` (`CREATE_ALWAYS` = 2), writes `"Hello, file!"` plus CR LF (`13, 10`), closes the HANDLE, and exits 0. `message_len EQU $ - message` is the byte count. `bytesWritten` is a `DWORD` — `WriteFile` writes a 32-bit count through that pointer, not a QWORD.

The frame is `main PROC FRAME` with `sub rsp, 40` / `.allocstack 40`. Stack arguments are stored as `DWORD PTR [rsp+32]` = 2, `DWORD PTR [rsp+40]` = `80h`, `QWORD PTR [rsp+48]` = 0. Access is `mov edx, 40000000h` (`GENERIC_WRITE`); share and security are `xor r8d, r8d` / `xor r9d, r9d`. After `CreateFileA`, `cmp rax, -1` / `je error` branches to status 1. The HANDLE is copied into RBX (volatile calls will clobber RAX). Expected exit: **0**. Side effect: `test.txt` holds `Hello, file!` and a CRLF.

```asm
; 01-create-file-write.asm
;
; Purpose: Create/truncate a file and write to it using Win32 APIs
; Expected exit code: 0
; Expected stdout: (none)
; Expected side effect: Creates/truncates test.txt with "Hello, file!\n"
;
; Demonstrates:
; - CreateFileA with CREATE_ALWAYS (equivalent to O_CREAT | O_TRUNC)
; - WriteFile to write data
; - CloseHandle to release the file handle
; - Error checking with INVALID_HANDLE_VALUE

.DATA
filename DB "test.txt", 0
message DB "Hello, file!", 13, 10
message_len EQU $ - message

bytesWritten DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; CreateFileA(filename, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL)
    lea     rcx, filename       ; lpFileName
    mov     edx, 40000000h      ; dwDesiredAccess = GENERIC_WRITE
    xor     r8d, r8d            ; dwShareMode = 0
    xor     r9d, r9d            ; lpSecurityAttributes = NULL
    mov     DWORD PTR [rsp+32], 2 ; dwCreationDisposition = CREATE_ALWAYS
    mov     DWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov     QWORD PTR [rsp+48], 0 ; hTemplateFile = NULL
    call    CreateFileA
    
    ; Check if handle is valid (not INVALID_HANDLE_VALUE = -1)
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; Save file handle
    
    ; WriteFile(hFile, message, message_len, &bytesWritten, NULL)
    mov     rcx, rbx            ; hFile
    lea     rdx, message        ; lpBuffer
    mov     r8d, message_len    ; nNumberOfBytesToWrite
    lea     r9, bytesWritten    ; lpNumberOfBytesWritten
    mov     QWORD PTR [rsp+32], 0 ; lpOverlapped = NULL
    call    WriteFile
    
    ; CloseHandle(hFile)
    mov     rcx, rbx
    call    CloseHandle
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

`lpNumberOfBytesWritten` must point at a DWORD. A QWORD pointer lets `WriteFile` update only the low 4 bytes and leave the high 4 stale.

### Opening and reading: `CreateFileA` + `ReadFile`

Listing `02-open-read-file` opens the same `test.txt` with `GENERIC_READ` (`80000000h`), `FILE_SHARE_READ` (1) in R8D, and `OPEN_EXISTING` (3). `ReadFile` asks for 256 bytes into `buffer`. After `CloseHandle`, `movzx ecx, BYTE PTR buffer` exits with the first byte (or 0 if the read left the buffer empty). A missing file takes the `cmp rax, -1` branch and exits 1.

`ReadFile` arguments: HANDLE in RCX, buffer in RDX, count in R8, address of a DWORD receive count in R9, overlapped = NULL at `[rsp+32]`. The frame is again 40 bytes. Expected exit: **72** (`'H'`, the first byte listing `01-create-file-write` stores). Open failure is still 1; ml64 CI runs this after listing 01's `test.txt` exists.

```asm
; 02-open-read-file.asm
;
; Purpose: Open an existing file and read from it
; Expected exit code: 72
; Expected stdout: (none)
;
; Demonstrates:
; - CreateFileA with OPEN_EXISTING (equivalent to open with O_RDONLY)
; - ReadFile to read data
; - Error handling with INVALID_HANDLE_VALUE

.DATA
filename DB "test.txt", 0
buffer DB 256 DUP(?)
bytesRead DWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; CreateFileA(filename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL)
    lea     rcx, filename       ; lpFileName
    mov     edx, 80000000h      ; dwDesiredAccess = GENERIC_READ
    mov     r8d, 1              ; dwShareMode = FILE_SHARE_READ
    xor     r9d, r9d            ; lpSecurityAttributes = NULL
    mov     DWORD PTR [rsp+32], 3 ; dwCreationDisposition = OPEN_EXISTING
    mov     DWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov     QWORD PTR [rsp+48], 0 ; hTemplateFile = NULL
    call    CreateFileA
    
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; Save file handle
    
    ; ReadFile(hFile, buffer, 256, &bytesRead, NULL)
    mov     rcx, rbx
    lea     rdx, buffer
    mov     r8d, 256
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    
    ; CloseHandle
    mov     rcx, rbx
    call    CloseHandle
    
    ; Exit with first byte (or 0 if empty)
    movzx   ecx, BYTE PTR buffer
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

`ReadFile` may return fewer bytes than you asked for (a short read) on a pipe or console. `bytesRead` = 0 with a TRUE return is end-of-file. FALSE means call `GetLastError`. This listing does not inspect `bytesRead`; it uses whatever is in `buffer[0]`.

## Seeking: `SetFilePointer` and `SetFilePointerEx`

Two APIs move the file pointer. The listings use both.

**`SetFilePointer`** (listing `03-set-file-pointer`) is the older form. Arguments: HANDLE in RCX, signed 32-bit distance in EDX, pointer to a high 32-bit LONG in R8 (NULL if the distance fits in 32 bits), move method in R9. Return is the new low DWORD, or `INVALID_SET_FILE_POINTER` on failure.

**`SetFilePointerEx`** (listings `14-set-file-pointer-begin` and `08-set-file-pointer-end`) takes a 64-bit signed offset in RDX, an optional pointer to a QWORD that receives the new position in R8, and the method in R9. Return is BOOL.

| Constant | Value | Meaning |
|----------|------:|---------|
| `FILE_BEGIN` | 0 | Offset is absolute from the start |
| `FILE_CURRENT` | 1 | Offset is added to the current pointer |
| `FILE_END` | 2 | Offset is relative to the end (0 seeks to EOF; use this to append) |

Listing `03-set-file-pointer` opens `test.txt` for read with `FILE_SHARE_READ` and `OPEN_EXISTING`, then calls `SetFilePointer` twice: distance 0 / `FILE_BEGIN`, then distance 5 / `FILE_CURRENT`. It does not read the return value. Open failure exits 1; success exits 0. Frame: `sub rsp, 40`.

```asm
; 03-set-file-pointer.asm
;
; Purpose: Demonstrate seeking in a file using SetFilePointer
; Expected exit code: 0
; Expected stdout: (none)
;
; Demonstrates:
; - SetFilePointer to move file position (equivalent to lseek)
; - FILE_BEGIN (0), FILE_CURRENT (1), FILE_END (2) constants

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointer:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; Open file for reading
    lea     rcx, filename
    mov     edx, 80000000h      ; GENERIC_READ
    mov     r8d, 1              ; FILE_SHARE_READ
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 3 ; OPEN_EXISTING
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    
    cmp     rax, -1
    je      error
    
    mov     rbx, rax
    
    ; SetFilePointer(hFile, 0, NULL, FILE_BEGIN)
    ; Seeks to beginning of file
    mov     rcx, rbx
    xor     edx, edx            ; lDistanceToMove = 0
    xor     r8, r8              ; lpDistanceToMoveHigh = NULL
    xor     r9d, r9d            ; dwMoveMethod = FILE_BEGIN (0)
    call    SetFilePointer
    
    ; SetFilePointer(hFile, 5, NULL, FILE_CURRENT)
    ; Moves 5 bytes forward from current position
    mov     rcx, rbx
    mov     edx, 5
    xor     r8, r8
    mov     r9d, 1              ; FILE_CURRENT
    call    SetFilePointer
    
    ; CloseHandle
    mov     rcx, rbx
    call    CloseHandle
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

Listing `14-set-file-pointer-begin` uses `SetFilePointerEx` to seek to offset 0 and checks the BOOL plus the reported position. The prologue is `push rbx` / `.pushreg rbx` / `sub rsp, 48` / `.allocstack 48`. Open is `GENERIC_READ`, exclusive share, `OPEN_EXISTING`. Then:

- RCX = HANDLE (from RBX)
- RDX = 0
- R8 = address of `newPos` in `.DATA?`
- R9D = 0 (`FILE_BEGIN`)

`test rax, rax` / `jz seek_failed` exits 2. `cmp newPos, 0` / `jne bad_pos` exits 4. Open failure exits 1. Success closes and exits 0. Expected exit: **0** when `test.txt` exists.

```asm
; Listing 14: SetFilePointerEx seek to beginning (LESSON.md asm block 7)
;
; Purpose: FILE_BEGIN seek with lpNewFilePointer receiving offset 0.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo14-set-file-pointer-begin.obj 14-set-file-pointer-begin.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-set-file-pointer-begin.exe 14-set-file-pointer-begin.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.DATA?
newPos QWORD ?

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointerEx:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 64
    .allocstack 64
    .endprolog

    lea rcx, filename
    mov edx, 80000000h
    xor r8d, r8d
    xor r9d, r9d
    mov DWORD PTR [rsp+32], 3
    mov DWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    jne have_handle
    mov ecx, 1
    call ExitProcess

have_handle:
    mov rbx, rax

    mov rcx, rbx
    xor rdx, rdx
    lea r8, newPos
    xor r9d, r9d              ; FILE_BEGIN
    call SetFilePointerEx
    test rax, rax
    jz seek_failed

    cmp newPos, 0
    jne bad_pos

    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

bad_pos:
    mov ecx, 4
    call ExitProcess

seek_failed:
    mov ecx, 2
    call ExitProcess
main ENDP

END
```

Listing `08-set-file-pointer-end` positions at EOF with `SetFilePointerEx`. It opens `test.txt` with `GENERIC_WRITE` and `OPEN_ALWAYS` (4), so a missing file is created. Offset 0, R8 = NULL (no new-position output), R9D = 2 (`FILE_END`). Seek failure exits 2; open failure exits 1; success closes and exits 0. Frame: `push rbx` + `sub rsp, 48`.

```asm
; Listing 08: SetFilePointerEx seek to end (LESSON.md asm block 8)
;
; Purpose: Position at end of file with FILE_END and offset 0 (append setup).
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo08-set-file-pointer-end.obj 08-set-file-pointer-end.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-set-file-pointer-end.exe 08-set-file-pointer-end.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN SetFilePointerEx:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 64
    .allocstack 64
    .endprolog

    lea rcx, filename
    mov edx, 40000000h
    xor r8d, r8d
    xor r9d, r9d
    mov DWORD PTR [rsp+32], 4
    mov DWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    jne have_handle
    mov ecx, 1
    call ExitProcess

have_handle:
    mov rbx, rax

    mov rcx, rbx
    xor rdx, rdx
    xor r8, r8
    mov r9d, 2                  ; FILE_END
    call SetFilePointerEx
    test rax, rax
    jz seek_failed

    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

seek_failed:
    mov ecx, 2
    call ExitProcess
main ENDP

END
```

## Closing a HANDLE

`CloseHandle` takes the HANDLE in RCX and returns BOOL. After a successful close, that HANDLE is invalid. A later use fails with `ERROR_INVALID_HANDLE` (6). Windows does not promise that new HANDLEs are small or sequential.

Listing `09-close-handle` opens `test.txt` `GENERIC_READ` / exclusive / `OPEN_EXISTING`, then `CloseHandle` and `test rax, rax`. Close failure exits 3; open failure exits 1; success exits 0. Frame: `push rbx` + `sub rsp, 48`.

```asm
; Listing 09: CloseHandle success check (LESSON.md asm block 9)
;
; Purpose: Close an open file handle and test the BOOL return.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo09-close-handle.obj 09-close-handle.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-close-handle.exe 09-close-handle.obj kernel32.lib

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 64
    .allocstack 64
    .endprolog

    lea rcx, filename
    mov edx, 80000000h
    xor r8d, r8d
    xor r9d, r9d
    mov DWORD PTR [rsp+32], 3
    mov DWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    jne have_handle
    mov ecx, 1
    call ExitProcess

have_handle:
    mov rbx, rax

    mov rcx, rbx
    call CloseHandle
    test rax, rax
    jz close_failed

    xor ecx, ecx
    call ExitProcess

close_failed:
    mov ecx, 3
    call ExitProcess
main ENDP

END
```

## Anonymous memory with VirtualAlloc

`VirtualAlloc` asks the kernel for virtual pages. The usual freestanding use is **anonymous** memory: not backed by a file.

1. `lpAddress` (RCX) — hint; 0 lets the kernel choose
2. `dwSize` (RDX) — byte length; the kernel rounds up to the page size (typically 4096)
3. `flAllocationType` (R8) — `MEM_COMMIT` = `1000h`, `MEM_RESERVE` = `2000h`; both = `3000h`
4. `flProtect` (R9) — `PAGE_READONLY` = 2, `PAGE_READWRITE` = 4, `PAGE_EXECUTE_READ` = `20h`

`VirtualFree` to release the whole allocation: address in RCX, **size 0** in RDX, `MEM_RELEASE` (`8000h`) in R8. A nonzero size with `MEM_RELEASE` is incorrect.

Failure is NULL (0), not −1. `test rax, rax` / `jz` is the right check. Pages come back zeroed.

Listing `04-virtual-alloc` allocates one 4096-byte `PAGE_READWRITE` page (`r8d = 3000h`, `r9d = 4`), writes 42 to `[rbx]`, reads it back into R12D, frees with `MEM_RELEASE`, and exits that 42. Alloc failure exits 1. Frame: `sub rsp, 40`. Expected exit: **42**.

```asm
; 04-virtual-alloc.asm
;
; Purpose: Allocate memory using VirtualAlloc (equivalent to anonymous mmap)
; Expected exit code: 42
; Expected stdout: (none)
;
; Demonstrates:
; - VirtualAlloc for anonymous memory allocation
; - MEM_COMMIT | MEM_RESERVE flags
; - PAGE_READWRITE protection
; - VirtualFree to release memory

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub     rsp, 40
    .allocstack 40
    .endprolog
    
    ; VirtualAlloc(NULL, 4096, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE)
    xor     ecx, ecx            ; lpAddress = NULL (let system choose)
    mov     edx, 4096           ; dwSize = 4096 bytes (one page)
    mov     r8d, 3000h          ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov     r9d, 4              ; flProtect = PAGE_READWRITE
    call    VirtualAlloc
    
    test    rax, rax
    jz      error
    
    mov     rbx, rax            ; Save memory address
    
    ; Write value 42 to allocated memory
    mov     BYTE PTR [rbx], 42
    
    ; Read it back
    movzx   r12d, BYTE PTR [rbx]
    
    ; VirtualFree(address, 0, MEM_RELEASE)
    mov     rcx, rbx
    xor     edx, edx            ; dwSize = 0 (required for MEM_RELEASE)
    mov     r8d, 8000h          ; dwFreeType = MEM_RELEASE
    call    VirtualFree
    
    ; Exit with value we stored
    mov     ecx, r12d
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

Listing `10-virtual-alloc-free` is the same allocate / store 42 / free path with a 32-byte frame and `GetLastError` on both failure legs. Success exits 42 (the stored byte, not a value read back). Alloc or free failure exits the `GetLastError` code.

```asm
; Listing 10: VirtualAlloc one page, write byte, VirtualFree (LESSON.md asm block 10)
;
; Purpose: Anonymous RW page via VirtualAlloc; release with MEM_RELEASE.
; Expected exit: 42 (byte stored in allocated page)
; Expected stdout: (none)
;
; Build: ml64 /c /Fo10-virtual-alloc-free.obj 10-virtual-alloc-free.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-virtual-alloc-free.exe 10-virtual-alloc-free.obj kernel32.lib

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    xor ecx, ecx
    mov edx, 4096
    mov r8d, 3000h
    mov r9d, 4
    call VirtualAlloc
    test rax, rax
    jz alloc_failed

    mov BYTE PTR [rax], 42

    mov rcx, rax
    xor edx, edx
    mov r8d, 8000h
    call VirtualFree
    test rax, rax
    jz free_failed

    mov ecx, 42
    call ExitProcess

alloc_failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess

free_failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess
main ENDP

END
```

`VirtualAlloc` is the replacement for anonymous `mmap`. Lesson 18 can map a save file with the mapping APIs below instead of a separate `ReadFile` into a `VirtualAlloc` buffer.

## Mapping a file: CreateFileMappingA and MapViewOfFile

Listing `05-file-mapping` maps `test.txt` read-only and exits with its first byte.

Sequence:

1. `CreateFileA` — `GENERIC_READ`, `FILE_SHARE_READ`, `OPEN_EXISTING`. HANDLE in RBX.
2. `CreateFileMappingA` — file HANDLE, NULL security, `PAGE_READONLY` (2) in R8D, size high = 0, size low = 0 at `[rsp+32]` (use the file size), name = NULL at `[rsp+40]`. Mapping HANDLE in R12. NULL return jumps to `error_close_file`.
3. `MapViewOfFile` — mapping HANDLE, `FILE_MAP_READ` (4) in EDX, offset 0, byte count 0 at `[rsp+32]` (entire file). View address in R13. NULL return jumps to `error_close_mapping`.
4. `movzx r14d, BYTE PTR [r13]` — first mapped byte.
5. `UnmapViewOfFile(R13)`, `CloseHandle(R12)`, `CloseHandle(RBX)`.
6. Exit with R14D, or 1 on any error.

The prologue pushes R12 and R13, then `sub rsp, 40`. Expected exit: **72** (first byte of `test.txt` after listing `01-create-file-write`). Failure paths still exit **1**.

```asm
; 05-file-mapping.asm
;
; Purpose: Map a file into memory (file-backed mmap equivalent)
; Expected exit code: 72
; Expected stdout: (none)
;
; Demonstrates:
; - CreateFileMappingA to create a file mapping object
; - MapViewOfFile to map the file into process address space
; - UnmapViewOfFile and CloseHandle to clean up

.DATA
filename DB "test.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CreateFileMappingA:PROC
EXTRN MapViewOfFile:PROC
EXTRN UnmapViewOfFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    r12
    .pushreg r12
    push    r13
    .pushreg r13
    sub rsp, 56
    .allocstack 56
    .endprolog
    
    ; Open file for reading
    lea     rcx, filename
    mov     edx, 80000000h      ; GENERIC_READ
    mov     r8d, 1              ; FILE_SHARE_READ
    xor     r9d, r9d
    mov     DWORD PTR [rsp+32], 3 ; OPEN_EXISTING
    mov     DWORD PTR [rsp+40], 80h
    mov     QWORD PTR [rsp+48], 0
    call    CreateFileA
    
    cmp     rax, -1
    je      error
    
    mov     rbx, rax            ; File handle
    
    ; CreateFileMappingA(hFile, NULL, PAGE_READONLY, 0, 0, NULL)
    mov     rcx, rbx
    xor     rdx, rdx            ; lpFileMappingAttributes = NULL
    mov     r8d, 2              ; flProtect = PAGE_READONLY
    xor     r9d, r9d            ; dwMaximumSizeHigh = 0
    mov     QWORD PTR [rsp+32], 0 ; dwMaximumSizeLow = 0 (use file size)
    mov     QWORD PTR [rsp+40], 0 ; lpName = NULL
    call    CreateFileMappingA
    
    test    rax, rax
    jz      error_close_file
    
    mov     r12, rax            ; Mapping handle
    
    ; MapViewOfFile(hFileMappingObject, FILE_MAP_READ, 0, 0, 0)
    mov     rcx, r12
    mov     edx, 4              ; dwDesiredAccess = FILE_MAP_READ
    xor     r8d, r8d            ; dwFileOffsetHigh = 0
    xor     r9d, r9d            ; dwFileOffsetLow = 0
    mov     QWORD PTR [rsp+32], 0 ; dwNumberOfBytesToMap = 0 (entire file)
    call    MapViewOfFile
    
    test    rax, rax
    jz      error_close_mapping
    
    mov     r13, rax            ; View address
    
    ; Read first byte from mapped view
    movzx   r14d, BYTE PTR [r13]
    
    ; Unmap view
    mov     rcx, r13
    call    UnmapViewOfFile
    
    ; Close mapping handle
    mov     rcx, r12
    call    CloseHandle
    
    ; Close file handle
    mov     rcx, rbx
    call    CloseHandle
    
    ; Exit with first byte
    mov     ecx, r14d
    jmp     done
    
error_close_mapping:
    mov     rcx, r12
    call    CloseHandle
    
error_close_file:
    mov     rcx, rbx
    call    CloseHandle
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

## Process id and the performance counter

Listing `06-get-process-id` calls `GetCurrentProcessId` (no arguments, DWORD in EAX), then `test eax, eax` / `seta cl` / `movzx ecx, cl`. That is 1 when the PID is above 0, else 0 — not a masked PID. Frame: `main PROC FRAME` with `sub rsp, 40` / `.allocstack 40`. Expected exit: **1**.

```asm
; 06-get-process-id.asm
;
; Purpose: Get current process ID (equivalent to getpid)
; Expected exit code: 1
; Expected stdout: (none)
;
; Demonstrates:
; - GetCurrentProcessId Win32 API

.CODE

EXTRN GetCurrentProcessId:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    
    ; GetCurrentProcessId returns DWORD in EAX
    call    GetCurrentProcessId
    
    test    eax, eax
    seta    cl
    movzx   ecx, cl
    call    ExitProcess
main ENDP

END
```

Listing `07-query-performance-counter` is the high-resolution timer pair. `QueryPerformanceFrequency` writes a QWORD frequency through RCX; `QueryPerformanceCounter` writes a QWORD tick count through RCX. Both return BOOL. The listing tests EAX after the counter call and exits 0 on success, 1 on failure. Frame: `sub rsp, 32`. This is the Win32 counterpart of a monotonic clock, not `GetTickCount`.

```asm
; 07-query-performance-counter.asm
;
; Purpose: Query high-resolution performance counter (timing)
; Expected exit code: 0
; Expected stdout: (none)
;
; Demonstrates:
; - QueryPerformanceCounter for high-resolution timing
; - QueryPerformanceFrequency to get timer frequency
; - Equivalent to Linux clock_gettime

.DATA
counter QWORD ?
frequency QWORD ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN QueryPerformanceFrequency:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    
    ; QueryPerformanceFrequency(&frequency)
    lea     rcx, frequency
    call    QueryPerformanceFrequency
    
    ; QueryPerformanceCounter(&counter)
    lea     rcx, counter
    call    QueryPerformanceCounter
    
    ; Both return nonzero on success
    test    eax, eax
    jz      error
    
    xor     ecx, ecx
    jmp     done
    
error:
    mov     ecx, 1
    
done:
    call    ExitProcess
main ENDP

END
```

## Shadow space is mandatory, even for one argument

The ABI requires 32 bytes of home space before every `call`. `ExitProcess` takes one argument in RCX; you still allocate the 32 bytes. Omit them and the callee may overwrite your return address or locals when it spills.

Listing `11-mandatory-shadow-space` is that minimum: `sub rsp, 32`, `xor ecx, ecx`, `call ExitProcess`. Expected exit: **0**.

```asm
; Listing 11: Mandatory 32-byte shadow before ExitProcess (LESSON.md asm block 11)
;
; Purpose: Even a one-argument import needs home space on the stack.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo11-mandatory-shadow-space.obj 11-mandatory-shadow-space.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-mandatory-shadow-space.exe 11-mandatory-shadow-space.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

Argument 5 and later live **above** the shadow space: `[rsp+32]`, `[rsp+40]`, `[rsp+48]`. `CreateFileA` needs those three slots. Listing `01-create-file-write` stores them after a 40-byte allocation; listing `13-open-missing-get-last-error` stores them as QWORDs after a 56-byte allocation (`32 + 24`).

At the point of a `call`, RSP must be 16-byte aligned (0 mod 16). `call` itself pushes an 8-byte return address, so a called procedure sees RSP ≡ 8 (mod 16). Subtracting an odd multiple of 8 (32 + 8 = 40 is the usual extra) restores 0 mod 16 for the next call.

Listing `12-callee-stack-alignment-40` makes that concrete. `myFunc` does `sub rsp, 40`, calls `SomeOtherFunc` (a `ret`-only procedure), then `add rsp, 40` and `ret`. `main` allocates 32 bytes, calls `myFunc`, and exits 0.

```asm
; Listing 12: Stack alignment with shadow + 8 (LESSON.md asm block 12)
;
; Purpose: Allocate 40 bytes before a nested call so RSP is 16-byte aligned at `call`.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo12-callee-stack-alignment-40.obj 12-callee-stack-alignment-40.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-callee-stack-alignment-40.exe 12-callee-stack-alignment-40.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

SomeOtherFunc PROC
    ret
SomeOtherFunc ENDP

myFunc PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    call SomeOtherFunc
    add rsp, 40
    ret
myFunc ENDP

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    call myFunc
    xor ecx, ecx
    call ExitProcess
main ENDP

END
```

Forget shadow space or alignment and you get an access violation or silent corruption, not a polite assembler diagnostic.

## Pipes and the process heap

Windows has no `brk`. Page-sized scratch still goes through `VirtualAlloc` (listings `04-virtual-alloc` and `10-virtual-alloc-free`). Small blocks go through `HeapAlloc` / `HeapFree` on a heap HANDLE from `GetProcessHeap` (or `HeapCreate`). `CreatePipe` writes two HANDLEs — read end, then write end — and `WriteFile` / `ReadFile` move bytes between them.

### CreatePipe: write three bytes, read them back

Listing `15-create-pipe` creates an anonymous pipe (`CreatePipe` with NULL security and 0 size), writes the three bytes `"ABC"` to `hWrite`, and reads three bytes into `readBuf`. Success copies `bytesRead` into **EBX**, closes both HANDLEs, then `mov ecx, ebx`. CloseHandle clobbers RCX; EBX is nonvolatile and holds the count across those calls. Expected exit: **3**. Failure of `CreatePipe` / `WriteFile` / `ReadFile` sets `ecx = 1` after the closes (or immediately if `CreatePipe` failed) and exits **1**.

The frame is `push rbx` / `.pushreg rbx` / `sub rsp, 64` / `.allocstack 64` so `[rsp+32]` can hold the NULL overlapped pointer for `WriteFile` and `ReadFile`. One push plus 64 keeps RSP ≡ 8 (mod 16) at each `call` and covers the extra stack argument.

```asm
; Listing 15: CreatePipe, WriteFile, ReadFile round trip
; Expected exit: 3
; Expected stdout: (none)

.DATA
payload BYTE "ABC"

.DATA?
hRead QWORD ?
hWrite QWORD ?
readBuf BYTE 8 DUP(?)
bytesWritten DWORD ?
bytesRead DWORD ?

.CODE
EXTRN CreatePipe:PROC
EXTRN WriteFile:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    sub     rsp, 64
    .allocstack 64
    .endprolog

    lea     rcx, hRead
    lea     rdx, hWrite
    xor     r8, r8
    xor     r9d, r9d
    call    CreatePipe
    test    rax, rax
    jz      fail

    mov     rcx, hWrite
    lea     rdx, payload
    mov     r8d, 3
    lea     r9, bytesWritten
    mov     QWORD PTR [rsp+32], 0
    call    WriteFile
    test    rax, rax
    jz      fail_close

    mov     rcx, hRead
    lea     rdx, readBuf
    mov     r8d, 3
    lea     r9, bytesRead
    mov     QWORD PTR [rsp+32], 0
    call    ReadFile
    test    rax, rax
    jz      fail_close

    mov     ebx, DWORD PTR bytesRead
    jmp     cleanup

fail_close:
    mov     rcx, hRead
    call    CloseHandle
    mov     rcx, hWrite
    call    CloseHandle
    mov     ecx, 1
    jmp     exit_proc

cleanup:
    mov     rcx, hRead
    call    CloseHandle
    mov     rcx, hWrite
    call    CloseHandle
    mov     ecx, ebx

exit_proc:
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
```

### HeapAlloc: sixteen 1-bytes, then the sum

Listing `16-heap-alloc-sum` calls `GetProcessHeap`, then `HeapAlloc` for 16 bytes with flags 0 (the `HEAP_ZERO_MEMORY EQU 8` at the top is unused). It fills the block with `rep stosb` of 1 (`cld` first), sums those 16 bytes into EAX (each `movzx` / `add` is 1), saves the sum in EBX, `HeapFree`s the block, and `mov ecx, ebx`. Expected exit: **16**. Failure of `GetProcessHeap` or `HeapAlloc` exits **1**. The prologue is `push rdi` / `push rsi` / `push rbx` with matching `.pushreg` directives, then `sub rsp, 32` / `.allocstack 32` — three pushes plus 32 keeps RSP ≡ 8 (mod 16) at each `call`.

```asm
; Listing 16: GetProcessHeap, HeapAlloc, HeapFree (LESSON.md)
; Expected exit: 16
; Expected stdout: (none)

HEAP_ZERO_MEMORY EQU 8

.DATA?
hHeap QWORD ?
pBuf QWORD ?

.CODE
EXTRN GetProcessHeap:PROC
EXTRN HeapAlloc:PROC
EXTRN HeapFree:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push    rdi
    .pushreg rdi
    push    rsi
    .pushreg rsi
    push    rbx
    .pushreg rbx
    sub     rsp, 32
    .allocstack 32
    .endprolog

    call    GetProcessHeap
    test    rax, rax
    jz      fail
    mov     hHeap, rax

    mov     rcx, hHeap
    xor     edx, edx
    mov     r8d, 16
    call    HeapAlloc
    test    rax, rax
    jz      fail
    mov     pBuf, rax

    mov     rdi, rax
    mov     ecx, 16
    mov     al, 1
    cld
    rep     stosb

    xor     eax, eax
    mov     rcx, 16
    mov     rsi, pBuf
sum_loop:
    movzx   edx, BYTE PTR [rsi]
    add     eax, edx
    inc     rsi
    loop    sum_loop

    mov     ebx, eax

    mov     rcx, hHeap
    xor     edx, edx
    mov     r8, pBuf
    call    HeapFree

    mov     ecx, ebx
    call    ExitProcess

fail:
    mov     ecx, 1
    call    ExitProcess
main ENDP
END
```

## Worked example: opening a missing file and recovering the error

**Task:** Open `C:\no\such\file.txt` for reading. On failure, exit with `GetLastError`. On success, close the HANDLE and exit 0.

**Reasoning:**

1. Allocate a frame that covers shadow space plus three stack arguments. Listing `13-open-missing-get-last-error` uses `push rbx` and `sub rsp, 56`.
2. RCX = path, EDX = `GENERIC_READ` (`80000000h`), R8D = 0, R9D = 0, `[rsp+32]` = 3 (`OPEN_EXISTING`) as a QWORD, `[rsp+40]` = `80h`, `[rsp+48]` = 0.
3. `CreateFileA` returns `INVALID_HANDLE_VALUE` (−1) on failure. Compare with `cmp rax, -1` / `je failed`.
4. Success copies the HANDLE to RBX, `CloseHandle`, `xor ecx, ecx`, `ExitProcess`.
5. Failure calls `GetLastError` (no arguments, 32-byte shadow already live) and `mov ecx, eax` so the process status is the error code.

```asm
; Listing 13: Open missing file; exit with GetLastError code (LESSON.md)
;
; Purpose: CreateFileA failure returns INVALID_HANDLE_VALUE; error via GetLastError.
; Expected exit: 3 (ERROR_PATH_NOT_FOUND for missing path components)
; Expected stdout: (none)
;
; Build: ml64 /c /Fo13-open-missing-get-last-error.obj 13-open-missing-get-last-error.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:13-open-missing-get-last-error.exe 13-open-missing-get-last-error.obj kernel32.lib

.DATA
path DB "C:\no\such\file.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 64
    .allocstack 64
    .endprolog

    lea rcx, path
    mov edx, 80000000h
    xor r8d, r8d
    xor r9d, r9d
    mov QWORD PTR [rsp+32], 3
    mov QWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA

    cmp rax, -1
    je failed

    mov rbx, rax
    mov rcx, rbx
    call CloseHandle
    xor ecx, ecx
    call ExitProcess

failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess
main ENDP

END
```

Expected exit: **3** (`ERROR_PATH_NOT_FOUND`). The path is `C:\no\such\file.txt`: a missing directory component, not a missing file in an existing directory (`ERROR_FILE_NOT_FOUND` = 2).

### A plausible wrong reading (and why it fails)

*"I already test BOOL returns with `test rax, rax` / `jz`. I can use that after `CreateFileA`."*

`CreateFileA` returns −1 on failure, not 0. −1 is nonzero, so `jz` never fires and you treat `INVALID_HANDLE_VALUE` as a live HANDLE. The next `ReadFile` or `CloseHandle` then fails (or worse). `VirtualAlloc` and `CreateFileMappingA` *do* return 0 on failure — that is a different contract. Read the return table before you pick `je` versus `jz`.

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| Fifth argument in a fifth register | Fifth argument is `[rsp+32]`, above the 32-byte shadow |
| Failure returns an errno in RAX | Failure is FALSE / NULL / `INVALID_HANDLE_VALUE`; the code is `GetLastError` |
| `CreateFileA` returns NULL on failure | It returns −1. `test rax, rax` misses it (listing `13-open-missing-get-last-error`) |
| `SetFilePointer` and `SetFilePointerEx` are the same call | `SetFilePointer` takes a 32-bit distance in EDX and an optional high pointer in R8 (listing `03-set-file-pointer`). `SetFilePointerEx` takes a 64-bit offset in RDX and an optional new-position pointer in R8 (listings `14-set-file-pointer-begin`, `08-set-file-pointer-end`) |
| `CloseHandle` returns the HANDLE | It returns BOOL. Listing `09-close-handle` tests RAX and exits 3 on FALSE |
| `ReadFile` always fills the request | Short reads are normal; 0 bytes + TRUE is EOF; FALSE is an error |
| `VirtualAlloc` returns −1 on failure | It returns 0. Listings `04-virtual-alloc` and `10-virtual-alloc-free` use `test rax, rax` |
| `VirtualFree` size equals the allocation | `MEM_RELEASE` requires size 0 |
| `lpNumberOfBytesWritten` is a QWORD | It is a DWORD. Listing `01-create-file-write` declares `bytesWritten DWORD ?` |
| Shadow space is optional for one-argument calls | Listing `11-mandatory-shadow-space` still does `sub rsp, 32` before `ExitProcess` |
| Linux `syscall` / RDI / RSI | User-mode Windows goes through `EXTRN` + `kernel32.lib`. Arguments are RCX, RDX, R8, R9. RDI and RSI are nonvolatile |
| `WriteConsoleA` vs `WriteFile` | These listings write files with `WriteFile`. Lesson 00 already used `WriteFile` on the standard output HANDLE |

## Check yourself

1. After `call CreateFileA`, RAX is `0FFFFFFFFFFFFFFFFh`. Is that a HANDLE you can pass to `WriteFile`? What do you call to get the error code?
2. Listing `01-create-file-write` uses `GENERIC_WRITE` and disposition 2. Does that create a missing `test.txt`? Does it empty an existing one?
3. You call `VirtualAlloc` with size 8192, allocation type `MEM_COMMIT | MEM_RESERVE`, protection `PAGE_READWRITE`. What value is in R8D in listing `04-virtual-alloc`? How do you detect failure?
4. `ReadFile` requested 512 bytes, `bytesRead` is 100, and the return is TRUE. Error or not? What does `bytesRead` = 0 with TRUE mean?
5. Why does listing `11-mandatory-shadow-space` execute `sub rsp, 32` before a one-argument `ExitProcess`? What goes wrong if you skip it?

## Key takeaways

- Win32 calls use RCX, RDX, R8, R9, then `[rsp+32]` onward; the return is RAX; the caller allocates 32 bytes of shadow space before every `call`.
- `CreateFileA` failure is −1; `VirtualAlloc` / mapping failure is 0; BOOL APIs fail with 0. The numeric error is `GetLastError` (listing `13-open-missing-get-last-error` exits **3** / `ERROR_PATH_NOT_FOUND` on `C:\no\such\file.txt`).
- `ReadFile` / `WriteFile` take a HANDLE, buffer, count, DWORD pointer, and overlapped (NULL for synchronous I/O). Short transfers are not automatically errors.
- `SetFilePointer` is the 32-bit-distance API; `SetFilePointerEx` is the 64-bit BOOL API. `FILE_BEGIN` = 0, `FILE_CURRENT` = 1, `FILE_END` = 2.
- `VirtualAlloc` with `3000h` / `PAGE_READWRITE` returns zeroed pages; `VirtualFree` with size 0 and `8000h` releases them. Listings `04-virtual-alloc` and `10-virtual-alloc-free` exit 42 after storing that byte.
- File-backed mapping is `CreateFileA` → `CreateFileMappingA` → `MapViewOfFile`, then `UnmapViewOfFile` and two `CloseHandle` calls (listing `05-file-mapping`).
- `CreatePipe` plus `WriteFile` / `ReadFile` of `"ABC"` is listing `15-create-pipe`. EBX holds `bytesRead` across the `CloseHandle`s; then `mov ecx, ebx` exits **3**. Listing `16-heap-alloc-sum` saves RDI/RSI/RBX, fills 16 heap bytes with 1, and exits **16**.
- There is no user-mode `syscall` for these services. You `EXTRN` the import and link `kernel32.lib`.

## Lookup

- Microsoft x64 calling convention: [x64 calling convention](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- File API: [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea), [ReadFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile), [WriteFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile), [CloseHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-closehandle), [SetFilePointer](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-setfilepointer), [SetFilePointerEx](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-setfilepointerex)
- Mapping: [CreateFileMappingA](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createfilemappinga), [MapViewOfFile](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-mapviewoffile), [UnmapViewOfFile](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-unmapviewoffile)
- Virtual memory: [VirtualAlloc](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc), [VirtualFree](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualfree)
- Errors: [GetLastError](https://learn.microsoft.com/en-us/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror), [system error codes](https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes)
- Timing and identity: [QueryPerformanceCounter](https://learn.microsoft.com/en-us/windows/win32/api/profileapi/nf-profileapi-queryperformancecounter), [QueryPerformanceFrequency](https://learn.microsoft.com/en-us/windows/win32/api/profileapi/nf-profileapi-queryperformancefrequency), [GetCurrentProcessId](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getcurrentprocessid)
- Standard handles: [GetStdHandle](https://learn.microsoft.com/en-us/windows/win32/api/processenv/nf-processenv-getstdhandle)

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build from an x64 Native Tools Command Prompt:

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
```

The exercises use the Win32 API and MASM syntax this lesson quotes.

**File operations:** two `WriteFile` calls to stdout, read one byte from stdin, open a missing file and handle `GetLastError`, open and close `NUL`, read from `NUL`, check the byte count after `WriteFile`, write to stdout, debug a handle-leak pattern, write to an invalid HANDLE.

**Error handling:** open `C:\` with `GENERIC_WRITE` (expect `ERROR_ACCESS_DENIED`), exit 1 on error.

**Seeking:** arithmetic offset without a seek call; open `NUL`, `SetFilePointerEx` to 0 (`FILE_BEGIN`), write, close, exit 0.

**Memory:** one page via `VirtualAlloc`, store 42, exit 42; store 99 at offset 100, exit 99; allocate then `VirtualFree`, exit 0; `GetProcessHeap` nonzero, exit 0; fill 16 bytes with 1, exit 16; copy four bytes from `.DATA`, sum them, exit 10.

**Other imports:** `GetCurrentProcessId`, then `test eax, eax` / `seta cl` so the status is **1** when the PID is above 0 (listing `06-get-process-id` — not `pid AND 07Fh`). `QueryPerformanceCounter`, exit 0. `CreatePipe`, write `"ABC"`, read three bytes, exit **3** (listing `15-create-pipe`).

Expected exits are in each file header under `exercises/` (there is no `exercises/08-syscalls-files-mmap/README.md`).
