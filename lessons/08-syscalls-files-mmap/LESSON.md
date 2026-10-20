# 08 — Win32 File API, HANDLEs, VirtualAlloc

You've been calling `GetStdHandle`, `WriteConsoleA`, and `ExitProcess` on faith since lesson 00. This lesson reveals the Microsoft x64 calling convention those imported functions demand, shows you how to read errors encoded as `BOOL` returns and `GetLastError`, and equips you to call `CreateFileA`, `ReadFile`, `WriteFile`, `CloseHandle`, `SetFilePointerEx`, and `VirtualAlloc` without ever invoking the C runtime. By the end you'll see that a Win32 API call is not a magic word—it's just a register contract you honor.

## What this lesson asks of you

- Place arguments in `rcx, rdx, r8, r9`, and additional arguments on the stack (starting at `[rsp+32]`), allocate 32-byte shadow space, and interpret the `rax` return.
- Recognize when `rax` encodes `FALSE` (0), `NULL` (0), or `INVALID_HANDLE_VALUE` (−1), then call `GetLastError` to retrieve the error code.
- Call `CreateFileA` with path, access flags (`GENERIC_READ`, `GENERIC_WRITE`), share mode, security attributes, creation disposition (`CREATE_ALWAYS`, `OPEN_EXISTING`), and attributes, receiving a `HANDLE`.
- Pass that `HANDLE` to `ReadFile`, `WriteFile`, `SetFilePointerEx`, or `CloseHandle`.
- Map anonymous memory with `VirtualAlloc` and release it with `VirtualFree`.
- Understand that Windows has no raw `syscall` instruction equivalent for user code—all kernel services go through imported DLL functions.

## The Microsoft x64 register protocol

A Win32 API call is an imported function from a kernel-mode DLL (typically `kernel32.dll`). The linker resolves `call FunctionName` to an indirect call through the Import Address Table (IAT). The CPU transfers control to the kernel-side implementation, which reads argument registers and stack slots, performs the requested operation, writes a return value into `rax`, and returns control to the next instruction after your `call`.

**Microsoft x64 calling convention:**

| Register | Role |
|----------|------|
| `rcx` | Argument 1 |
| `rdx` | Argument 2 |
| `r8` | Argument 3 |
| `r9` | Argument 4 |
| `[rsp+32]` | Argument 5 (first stack parameter, above shadow space) |
| `[rsp+40]` | Argument 6 |
| `[rsp+48]` | Argument 7, etc. |
| `rax` | Return value (integer, pointer, or `BOOL`) |

The caller must allocate **32 bytes of shadow space** (home space) at `[rsp]` to `[rsp+31]` before every `call`, even if the function has fewer than four arguments. This space is reserved for the callee to spill register arguments if needed.

**Volatile (caller-saved) registers:** `rax`, `rcx`, `rdx`, `r8`, `r9`, `r10`, `r11`, `xmm0`–`xmm5`  
**Nonvolatile (callee-saved) registers:** `rbx`, `rbp`, `rdi`, `rsi`, `r12`–`r15`, `xmm6`–`xmm15`

**Note:** On Windows, `rdi` and `rsi` are **nonvolatile** (must be saved/restored if modified). This is the opposite of the Linux System V ABI.

**Common Win32 functions:**

| Function | Arg1 (`rcx`) | Arg2 (`rdx`) | Arg3 (`r8`) | Arg4 (`r9`) | Arg5+ (`[rsp+32]…`) |
|----------|--------------|--------------|-------------|-------------|---------------------|
| `CreateFileA` | path | access | share | security | disposition, attrs, template |
| `ReadFile` | handle | buffer | count | &read | overlapped |
| `WriteFile` | handle | buffer | count | &written | overlapped |
| `CloseHandle` | handle | — | — | — | — |
| `SetFilePointerEx` | handle | offset | &newpos | whence | — |
| `VirtualAlloc` | addr | size | type | protect | — |
| `VirtualFree` | addr | size | type | — | — |
| `GetLastError` | — | — | — | — | — |
| `ExitProcess` | exitCode | — | — | — | — |

## Interpreting Win32 returns and GetLastError

Most Win32 file functions return `BOOL` (nonzero = `TRUE` = success, zero = `FALSE` = failure) or a pointer/handle (non-null/non-`INVALID_HANDLE_VALUE` = success). On failure, the error code is not returned directly—it's stored in thread-local storage and retrieved by calling `GetLastError`.

**Return patterns:**

| Function | Success | Failure |
|----------|---------|---------|
| `CreateFileA` | Valid `HANDLE` (nonzero, ≠ −1) | `INVALID_HANDLE_VALUE` (−1, or `0xFFFFFFFFFFFFFFFF`) |
| `ReadFile`, `WriteFile` | Nonzero (`TRUE`) | Zero (`FALSE`) |
| `CloseHandle` | Nonzero (`TRUE`) | Zero (`FALSE`) |
| `SetFilePointerEx` | Nonzero (`TRUE`) | Zero (`FALSE`) |
| `VirtualAlloc` | Valid address (nonzero) | `NULL` (0) |
| `VirtualFree` | Nonzero (`TRUE`) | Zero (`FALSE`) |

**Detection pattern for `BOOL` functions:**

```asm
call WriteFile
test rax, rax
jz error_handler        ; Zero = FALSE = failure
; success path: rax was nonzero (TRUE)
jmp continue

error_handler:
    call GetLastError   ; rax = error code (e.g., ERROR_ACCESS_DENIED = 5)
    ; handle error
```

**Detection pattern for `CreateFileA`:**

```asm
call CreateFileA
cmp rax, -1             ; INVALID_HANDLE_VALUE
je error_handler
; success path: rax holds a valid HANDLE

error_handler:
    call GetLastError
    ; rax = error code (e.g., ERROR_FILE_NOT_FOUND = 2)
```

**Common error codes:**

| Code | Name | Meaning |
|-----:|------|---------|
| 2 | `ERROR_FILE_NOT_FOUND` | File does not exist |
| 3 | `ERROR_PATH_NOT_FOUND` | Directory does not exist |
| 5 | `ERROR_ACCESS_DENIED` | Permission denied |
| 32 | `ERROR_SHARING_VIOLATION` | File is locked by another process |
| 80 | `ERROR_FILE_EXISTS` | File already exists (when using `CREATE_NEW`) |

**Why `GetLastError` is needed:** Unlike Linux, where the return value encodes both success/failure and the error code, Windows separates the two. This allows functions to return useful values (like byte counts or handles) without reserving a special failure range.

## HANDLEs and the CreateFile-Read-Write-Close cycle

A **`HANDLE`** is a 64-bit opaque pointer the kernel hands you as a handle for an open file, console, or other kernel object. You pass that handle to `ReadFile`, `WriteFile`, `SetFilePointerEx`, and `CloseHandle`. Three standard handles are pre-opened for every console process:

| Constant | Value | Name | Use |
|----------|------:|------|-----|
| `STD_INPUT_HANDLE` | −10 | stdin | Standard input (keyboard, redirected file, or pipe) |
| `STD_OUTPUT_HANDLE` | −11 | stdout | Standard output (console, redirected file, or pipe) |
| `STD_ERROR_HANDLE` | −12 | stderr | Standard error (usually the console, unbuffered) |

To obtain a standard handle, call `GetStdHandle(constant)`. The returned `HANDLE` is a kernel object identifier, not a small integer like Linux file descriptors.

### Opening a file

`CreateFileA` (the ANSI version; `CreateFileW` is the Unicode version) takes seven arguments:

1. `lpFileName` (`rcx`): Null-terminated path string
2. `dwDesiredAccess` (`rdx`): Access flags (`GENERIC_READ`, `GENERIC_WRITE`, `GENERIC_READ | GENERIC_WRITE`)
3. `dwShareMode` (`r8`): Share flags (0 = exclusive, `FILE_SHARE_READ` = 1, `FILE_SHARE_WRITE` = 2)
4. `lpSecurityAttributes` (`r9`): Security descriptor pointer (usually `NULL` = 0)
5. `dwCreationDisposition` (`[rsp+32]`): Creation mode (`CREATE_ALWAYS`, `OPEN_EXISTING`, `OPEN_ALWAYS`, `CREATE_NEW`, `TRUNCATE_EXISTING`)
6. `dwFlagsAndAttributes` (`[rsp+40]`): Attributes (e.g., `FILE_ATTRIBUTE_NORMAL` = 0x80)
7. `hTemplateFile` (`[rsp+48]`): Template file handle (usually `NULL` = 0)

**Common access flags:**

| Flag | Value | Meaning |
|------|------:|---------|
| `GENERIC_READ` | 0x80000000 | Open for reading |
| `GENERIC_WRITE` | 0x40000000 | Open for writing |
| `GENERIC_READ \| GENERIC_WRITE` | 0xC0000000 | Open for reading and writing |

**Creation disposition flags:**

| Flag | Value | Meaning |
|------|------:|---------|
| `CREATE_NEW` | 1 | Create new file; fail if exists |
| `CREATE_ALWAYS` | 2 | Create new file; truncate if exists |
| `OPEN_EXISTING` | 3 | Open existing file; fail if doesn't exist |
| `OPEN_ALWAYS` | 4 | Open existing file; create if doesn't exist |
| `TRUNCATE_EXISTING` | 5 | Open and truncate to zero; fail if doesn't exist |

To open an existing file for reading:

```asm
EXTERN CreateFileA:PROC
EXTERN GetLastError:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "data.txt", 0

.code
main PROC
    sub rsp, 56             ; shadow space (32) + 3 args (24) = 56
    
    lea rcx, path           ; lpFileName
    mov rdx, 80000000h      ; dwDesiredAccess = GENERIC_READ
    xor r8, r8              ; dwShareMode = 0 (exclusive)
    xor r9, r9              ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    cmp rax, -1             ; INVALID_HANDLE_VALUE
    je open_failed
    ; rax now holds the file HANDLE
    
    ; (close and exit...)
    add rsp, 56
    mov rcx, 0
    call ExitProcess
    
open_failed:
    call GetLastError       ; rax = ERROR_FILE_NOT_FOUND (2)
    mov rcx, rax
    add rsp, 56
    call ExitProcess
main ENDP
END
```

To create a new file (or truncate an existing one) for writing:

```asm
    sub rsp, 56
    lea rcx, path
    mov rdx, 40000000h      ; GENERIC_WRITE
    xor r8, r8
    xor r9, r9
    mov QWORD PTR [rsp+32], 2   ; CREATE_ALWAYS (create or truncate)
    mov QWORD PTR [rsp+40], 80h ; FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    add rsp, 56
```

Windows has no direct equivalent to Unix permission modes (0644, etc.). File permissions are controlled by Access Control Lists (ACLs), which are beyond the scope of this lesson. For simple file creation, use `FILE_ATTRIBUTE_NORMAL` (0x80).

### Reading and writing

Once you have a handle, `ReadFile` and `WriteFile` transfer bytes. Both take five arguments:

1. `hFile` (`rcx`): The file `HANDLE`
2. `lpBuffer` (`rdx`): Pointer to the buffer
3. `nNumberOfBytesToRead/Write` (`r8`): Byte count
4. `lpNumberOfBytesRead/Written` (`r9`): Pointer to a `DWORD` (4 bytes) to receive the actual byte count
5. `lpOverlapped` (`[rsp+32]`): Overlapped I/O structure pointer (use `NULL` = 0 for synchronous I/O)

**ReadFile example:**

```asm
EXTERN ReadFile:PROC

.data?
buffer BYTE 256 DUP(?)
bytesRead DWORD ?

.code
; assume rax holds file HANDLE from CreateFileA
    mov rbx, rax            ; save handle in nonvolatile rbx
    sub rsp, 40             ; shadow space (32) + 1 arg (8) = 40
    
    mov rcx, rbx            ; hFile
    lea rdx, buffer         ; lpBuffer
    mov r8, 256             ; nNumberOfBytesToRead
    lea r9, bytesRead       ; lpNumberOfBytesRead
    mov QWORD PTR [rsp+32], 0   ; lpOverlapped = NULL
    call ReadFile
    
    add rsp, 40
    test rax, rax
    jz read_failed          ; FALSE = failure
    ; bytesRead now holds the actual count (may be less than 256)
    ; bytesRead = 0 means end-of-file
```

`ReadFile` may return fewer bytes than you requested (short read), especially when reading from a pipe or console. The `lpNumberOfBytesRead` output is zero at end-of-file. A return of `FALSE` (0) means an error occurred; call `GetLastError` to retrieve the code.

**WriteFile example:**

```asm
EXTERN WriteFile:PROC

.data
message BYTE "Hello, file!", 13, 10    ; CRLF line ending
message_len EQU $ - message

.data?
bytesWritten DWORD ?

.code
    sub rsp, 40
    
    mov rcx, rbx            ; hFile (saved from CreateFileA)
    lea rdx, message        ; lpBuffer
    mov r8, message_len     ; nNumberOfBytesToWrite
    lea r9, bytesWritten    ; lpNumberOfBytesWritten
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    add rsp, 40
    test rax, rax
    jz write_failed
    ; bytesWritten now holds the actual count
```

**Important:** `lpNumberOfBytesWritten` is a pointer to a `DWORD` (32-bit), not a `QWORD` (64-bit). Passing a `QWORD` will cause the function to write the count to the lower 4 bytes and leave the upper 4 bytes untouched, which may corrupt adjacent data.

### Seeking

`SetFilePointerEx` moves the file offset. It takes four arguments:

1. `hFile` (`rcx`): The file `HANDLE`
2. `liDistanceToMove` (`rdx`): 64-bit signed offset (passed as a `LARGE_INTEGER`, which is just a `QWORD` in assembly)
3. `lpNewFilePointer` (`r8`): Pointer to a `QWORD` to receive the new offset (can be `NULL` if you don't need it)
4. `dwMoveMethod` (`r9`): Seek mode

**Seek modes:**

| Constant | Value | Meaning |
|----------|------:|---------|
| `FILE_BEGIN` | 0 | Set offset to `liDistanceToMove` (absolute) |
| `FILE_CURRENT` | 1 | Add `liDistanceToMove` to current offset (relative) |
| `FILE_END` | 2 | Set offset to end of file + `liDistanceToMove` |

**Example: seek to beginning of file:**

```asm
EXTERN SetFilePointerEx:PROC

.data?
newPos QWORD ?

.code
    sub rsp, 32             ; shadow space only (4 register args)
    
    mov rcx, rbx            ; hFile (saved from CreateFileA)
    xor rdx, rdx            ; liDistanceToMove = 0
    lea r8, newPos          ; lpNewFilePointer
    xor r9, r9              ; dwMoveMethod = FILE_BEGIN
    call SetFilePointerEx
    
    add rsp, 32
    test rax, rax
    jz seek_failed
    ; newPos now holds the new file offset (should be 0)
```

To seek to the end of a file (to append), use `FILE_END` with offset 0:

```asm
    mov rcx, rbx
    xor rdx, rdx            ; offset 0
    xor r8, r8              ; lpNewFilePointer = NULL (don't need result)
    mov r9, 2               ; FILE_END
    call SetFilePointerEx
```

### Closing

`CloseHandle` releases the handle:

```asm
EXTERN CloseHandle:PROC

.code
    sub rsp, 32
    mov rcx, rbx            ; HANDLE to close
    call CloseHandle
    add rsp, 32
    test rax, rax
    jz close_failed         ; FALSE = failure
    ; Success: rax was nonzero (TRUE)
```

After `CloseHandle`, the handle is invalid. Attempting to use it in subsequent calls will fail with `ERROR_INVALID_HANDLE` (6). Unlike Linux file descriptors, Windows does not guarantee that new handles will be numerically sequential or reuse low values first—handles are opaque kernel pointers.

## Anonymous memory allocation with VirtualAlloc

`VirtualAlloc` asks the kernel for virtual memory. The most common use in freestanding programs is **anonymous allocation**: memory not backed by any file.

**Arguments for VirtualAlloc:**

1. `lpAddress` (`rcx`): Address hint (usually `NULL` = 0, let kernel choose)
2. `dwSize` (`rdx`): Length in bytes (kernel rounds up to page size, typically 4096)
3. `flAllocationType` (`r8`): Allocation type flags
4. `flProtect` (`r9`): Protection flags

**Allocation type flags:**

| Flag | Value | Meaning |
|------|------:|---------|
| `MEM_COMMIT` | 0x1000 | Allocate physical memory for pages |
| `MEM_RESERVE` | 0x2000 | Reserve address space without physical memory |
| `MEM_COMMIT \| MEM_RESERVE` | 0x3000 | Reserve and commit in one call (most common) |

**Protection flags:**

| Flag | Value | Meaning |
|------|------:|---------|
| `PAGE_READONLY` | 2 | Read-only |
| `PAGE_READWRITE` | 4 | Read and write |
| `PAGE_EXECUTE_READ` | 0x20 | Execute and read (for JIT code) |

**Example: allocate one page (4096 bytes) of read-write memory:**

```asm
EXTERN VirtualAlloc:PROC
EXTERN VirtualFree:PROC
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    
    xor rcx, rcx            ; lpAddress = NULL (let kernel choose)
    mov rdx, 4096           ; dwSize = one page
    mov r8, 3000h           ; flAllocationType = MEM_COMMIT | MEM_RESERVE
    mov r9, 4               ; flProtect = PAGE_READWRITE
    call VirtualAlloc
    
    test rax, rax
    jz alloc_failed         ; NULL = failure
    ; rax now holds the base address of the allocated memory
    
    ; You can now read and write through the pointer in rax
    ; The memory is initialized to zero
    mov BYTE PTR [rax], 42  ; write a byte
    
    ; Release the memory
    mov rcx, rax            ; lpAddress
    xor rdx, rdx            ; dwSize = 0 (required for MEM_RELEASE)
    mov r8, 8000h           ; dwFreeType = MEM_RELEASE
    call VirtualFree
    
    add rsp, 32
    test rax, rax
    jz free_failed          ; FALSE = failure
    
    mov rcx, 0
    call ExitProcess
    
alloc_failed:
    call GetLastError       ; rax = error code
    mov rcx, rax
    add rsp, 32
    call ExitProcess
    
free_failed:
    call GetLastError
    mov rcx, rax
    add rsp, 32
    call ExitProcess
main ENDP
END
```

**Important differences from Linux `mmap`:**

- `VirtualAlloc` always returns `NULL` (0) on failure, not a negative value. Check with `test rax, rax; jz error`.
- `VirtualFree` requires `dwSize = 0` and `dwFreeType = MEM_RELEASE` (0x8000) to free the entire allocation.
- Windows page size is typically 4096 bytes (same as x86-64 Linux), but you can query it with `GetSystemInfo`.
- Allocated memory is always zeroed by the kernel.

**Why VirtualAlloc?** Lesson 18's save file will use `CreateFileMapping` and `MapViewOfFile` to map the save data directly into memory, avoiding a separate `ReadFile` call. `VirtualAlloc` is useful when you need scratch space larger than the stack, or when you want to control alignment and page boundaries.

## Shadow space is mandatory, even for functions with < 4 arguments

The Microsoft x64 ABI requires the caller to allocate **32 bytes of shadow space** (also called "home space") on the stack before every `call`, even if the function has fewer than four arguments. This space is at `[rsp]` to `[rsp+31]` and is reserved for the callee to spill the four register arguments (`rcx`, `rdx`, `r8`, `r9`) if needed.

**Example: calling a one-argument function:**

```asm
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32             ; allocate shadow space (4 × 8 = 32 bytes)
    mov rcx, 0              ; first argument: exit code 0
    call ExitProcess
    ; ExitProcess never returns, but if it did:
    ; add rsp, 32
    ; ret
main ENDP
END
```

Even though `ExitProcess` takes only one argument, you must allocate 32 bytes. If you omit this, the callee may overwrite your return address or local variables when spilling registers.

**Fifth and subsequent arguments** go on the stack **above** the shadow space, starting at `[rsp+32]`, `[rsp+40]`, etc. You saw this in the `CreateFileA` example, which has seven arguments.

**Stack alignment:** At the point of a `call` instruction, `rsp` must be 16-byte aligned. The `call` itself pushes an 8-byte return address, leaving `rsp` misaligned inside the function. To restore alignment, allocate an odd multiple of 8 bytes. For functions that make calls, the typical pattern is:

```asm
myFunc PROC
    sub rsp, 40             ; 32 (shadow) + 8 (alignment) = 40
    ; now rsp is 16-byte aligned again
    call SomeOtherFunc
    add rsp, 40
    ret
myFunc ENDP
```

If you forget shadow space or misalign the stack, Windows may crash your program with an access violation or silently corrupt data.

## Windows equivalents to other Linux syscalls

Windows has no direct equivalent to Linux's `brk` syscall, which adjusts the program break (end of the data segment). On Windows, dynamic memory allocation uses one of three mechanisms:

1. **`VirtualAlloc` / `VirtualFree`:** Low-level page-granular allocation (covered above). Use this when you need large blocks or control over page boundaries.
2. **`HeapAlloc` / `HeapFree`:** Higher-level heap allocation. Requires a heap handle (obtain with `GetProcessHeap` or `HeapCreate`). Suitable for small, frequent allocations.
3. **C runtime `malloc` / `free`:** If you link with the CRT (which this course avoids), these wrap `HeapAlloc`.

For this course, use `VirtualAlloc` for memory allocation. Lesson 18's dynamic data structures (trees, lists) will demonstrate reusable memory pools built on top of `VirtualAlloc`.

**Pipes, process IDs, and timing:**

- **Pipes:** `CreatePipe` creates a unidirectional pipe (analogous to Linux `pipe(2)`). It takes pointers to two `HANDLE` variables (read end and write end).
- **Process ID:** `GetCurrentProcessId` returns the process ID as a `DWORD` (32-bit). No arguments.
- **Timing:** Lesson 15 will cover `QueryPerformanceCounter` and `QueryPerformanceFrequency` (high-resolution timer, analogous to Linux `clock_gettime(CLOCK_MONOTONIC, ...)`), and `Sleep` (millisecond granularity sleep, analogous to `nanosleep` but coarser).

## Worked example: opening a missing file and recovering the error

**Task:** Open `C:\no\such\file.txt` for reading. If it fails, call `GetLastError` and exit with the error code as the status. If it succeeds, close the handle and exit 0.

**Step-by-step reasoning:**

1. **Call `CreateFileA`:** Allocate shadow space (32 bytes) + 3 stack arguments (24 bytes) = 56 bytes total (multiple of 16 for alignment).
2. **Arguments:** Path in `rcx`, `GENERIC_READ` (0x80000000) in `rdx`, share mode 0 in `r8`, security attributes `NULL` in `r9`, disposition `OPEN_EXISTING` (3) in `[rsp+32]`, attributes `FILE_ATTRIBUTE_NORMAL` (0x80) in `[rsp+40]`, template `NULL` in `[rsp+48]`.
3. **Check return:** `CreateFileA` returns `INVALID_HANDLE_VALUE` (−1) on failure.
4. **Distinguish failure:** Use `cmp rax, -1` then `je` (jump if equal).
5. **Recover error code:** Call `GetLastError` with no arguments; it returns the error code in `rax`.
6. **Exit with error code:** Move `rax` to `rcx` and call `ExitProcess`.

```asm
EXTERN CreateFileA:PROC
EXTERN CloseHandle:PROC
EXTERN GetLastError:PROC
EXTERN ExitProcess:PROC

.data
path BYTE "C:\no\such\file.txt", 0

.code
main PROC
    sub rsp, 56             ; shadow space (32) + 3 args (24)
    
    lea rcx, path           ; lpFileName
    mov rdx, 80000000h      ; dwDesiredAccess = GENERIC_READ
    xor r8, r8              ; dwShareMode = 0
    xor r9, r9              ; lpSecurityAttributes = NULL
    mov QWORD PTR [rsp+32], 3   ; dwCreationDisposition = OPEN_EXISTING
    mov QWORD PTR [rsp+40], 80h ; dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL
    mov QWORD PTR [rsp+48], 0   ; hTemplateFile = NULL
    call CreateFileA
    
    add rsp, 56             ; deallocate before branching
    cmp rax, -1             ; INVALID_HANDLE_VALUE
    je failed
    
    ; Success path: rax holds valid HANDLE
    mov rbx, rax            ; save handle in nonvolatile rbx
    sub rsp, 32
    mov rcx, rbx
    call CloseHandle        ; close the handle
    add rsp, 32
    
    mov rcx, 0              ; exit 0
    call ExitProcess
    
failed:
    call GetLastError       ; rax = ERROR_FILE_NOT_FOUND (2)
    mov rcx, rax            ; exit with error code
    call ExitProcess
main ENDP
END
```

**Expected output:** Exit status 2 (`ERROR_FILE_NOT_FOUND` = "The system cannot find the file specified").

**Plausible wrong reading and why it fails:**

*"The `cmp rax, -1` checks for `INVALID_HANDLE_VALUE`, but maybe I should use `test rax, rax` and `jz` (jump if zero) like I do for `BOOL` returns."*

**Why it's wrong:** `CreateFileA` returns `INVALID_HANDLE_VALUE` (−1, or `0xFFFFFFFFFFFFFFFF`) on failure, not `NULL` (0). A `test rax, rax` followed by `jz` checks if `rax` is zero, which would be a valid (though unlikely) handle value. If you use `jz`, you'll miss the failure case. Always check the documentation for the specific return value: `CreateFileA` and `CreateFileW` return `INVALID_HANDLE_VALUE` on failure, while many other Win32 functions return `NULL` (0) or `FALSE` (0).

## Distinctions worth keeping straight

| Confusion | Reality |
|-----------|---------|
| Fifth argument goes in a fifth register | Fifth argument goes on the stack at `[rsp+32]`, above shadow space |
| A Win32 failure returns an error code in `rax` | Failure returns `FALSE` (0) or `INVALID_HANDLE_VALUE` (−1); call `GetLastError` to retrieve the error code |
| `CreateFileA` returns `NULL` on failure | `CreateFileA` returns `INVALID_HANDLE_VALUE` (−1) on failure, not `NULL` (0) |
| `CloseHandle` returns the handle on success | `CloseHandle` returns `TRUE` (nonzero) on success, `FALSE` (0) on error |
| `ReadFile` always reads the requested count | `ReadFile` may return fewer bytes (short read), 0 at EOF (in `lpNumberOfBytesRead`), or `FALSE` on error |
| `VirtualAlloc` returns −1 on failure | `VirtualAlloc` returns `NULL` (0) on failure; nonzero is a valid address |
| You can `WriteFile` to any `HANDLE` | `HANDLE` must be valid (returned by `CreateFileA` or `GetStdHandle`) and opened with write permission |
| Shadow space is optional for small functions | Shadow space (32 bytes) is mandatory before every `call`, even for zero-argument functions |
| `lpNumberOfBytesWritten` is a `QWORD` pointer | It's a `DWORD` pointer (4 bytes, not 8); passing a `QWORD` will corrupt adjacent memory |

## Check yourself

1. After `call CreateFileA`, you have `rax = 0xFFFFFFFFFFFFFFFF` (−1). Is this a valid `HANDLE`, or an error? What should you call next to retrieve the error code?
   
2. You call `CreateFileA` with `GENERIC_WRITE`, creation disposition `CREATE_ALWAYS`, and attributes `FILE_ATTRIBUTE_NORMAL`. Does this create the file if it's missing? Does it empty the file if it exists?

3. You call `VirtualAlloc` with size 8192, allocation type `MEM_COMMIT | MEM_RESERVE` (0x3000), and protection `PAGE_READWRITE` (4). What value should go in `r8`? Can you write to the returned address?

4. Your `ReadFile` call requested 512 bytes but `lpNumberOfBytesRead` contains 100, and the return value is `TRUE`. Is this an error, or can this happen in normal operation? What does `lpNumberOfBytesRead = 0` with return `TRUE` mean?

5. You accidentally allocate only 24 bytes of stack space before calling `CreateFileA` (which has 7 arguments). What will likely happen when `CreateFileA` tries to spill its register arguments to shadow space?

## Key takeaways

- Win32 API calls follow the Microsoft x64 calling convention: arguments in `rcx, rdx, r8, r9`, then stack at `[rsp+32]`, return in `rax`.
- Caller must allocate 32 bytes of shadow space before every `call`, even for functions with fewer than four arguments.
- Most Win32 functions return `BOOL` (nonzero = success, zero = failure) or `INVALID_HANDLE_VALUE`/`NULL` on error; call `GetLastError` to retrieve the error code.
- `CreateFileA` returns a `HANDLE` (opaque pointer) on success or `INVALID_HANDLE_VALUE` (−1) on failure.
- `ReadFile` and `WriteFile` may transfer fewer bytes than requested (short reads/writes are not errors); check `lpNumberOfBytesRead/Written`.
- `VirtualAlloc` with `MEM_COMMIT | MEM_RESERVE` allocates zeroed memory; `VirtualFree` with `MEM_RELEASE` releases it (size must be 0 for `MEM_RELEASE`).
- Windows has no raw `syscall` instruction for user code—all kernel services go through imported DLL functions (`kernel32.lib`, `user32.lib`, etc.).

## Lookup

- Microsoft x64 calling convention: [x64 calling convention (Microsoft Learn)](https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention)
- Win32 file functions: [CreateFileA](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea), [ReadFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile), [WriteFile](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-writefile), [CloseHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-closehandle), [SetFilePointerEx](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-setfilepointerex)
- Virtual memory: [VirtualAlloc](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualalloc), [VirtualFree](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualfree)
- Error handling: [GetLastError](https://learn.microsoft.com/en-us/windows/win32/api/errhandlingapi/nf-errhandlingapi-getlasterror), [System Error Codes](https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes)
- Standard handles: [GetStdHandle](https://learn.microsoft.com/en-us/windows/win32/api/processenv/nf-processenv-getstdhandle)

## Standalone listings

These names exist on the listings branch. Prose here keeps LISTING-PENDING until this branch quotes them verbatim.

<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/01-create-file-write.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/02-open-read-file.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/03-set-file-pointer.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/04-virtual-alloc.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/05-file-mapping.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/06-get-process-id.asm -->
<!-- LISTING-PENDING: lessons/08-syscalls-files-mmap/listings/07-query-performance-counter.asm -->

## Exercises

Twenty-four drills under `exercises/`. Solutions mirror the names under `solutions/`. Build with (from x64 Native Tools Command Prompt):

```bat
ml64 /c FILE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE FILE.obj kernel32.lib && FILE.exe
```

The exercises and solutions are written by a separate author and use the Win32 API and MASM syntax covered in this lesson. They are organized by category:

**File operations:** Two `WriteFile` calls to stdout, read one byte from stdin, open missing file and handle error with `GetLastError`, open and close `NUL` (Windows equivalent of `/dev/null`), read from `NUL`, check byte count after `WriteFile`, two separate `WriteFile` calls, write to stdout, debug handle leak pattern, write to invalid handle and handle error.

**Error handling:** Open `C:\` with `GENERIC_WRITE` (should fail with `ERROR_ACCESS_DENIED`), exit 1 on error.

**Seeking:** Arithmetic offset computation (no `SetFilePointerEx` call), open `NUL`, `SetFilePointerEx` to 0 (`FILE_BEGIN`), write, close, exit 0.

**Memory mapping:** Allocate one page with `VirtualAlloc`, store 42, exit 42. Allocate, store 99 at offset 100, exit 99. Allocate then free with `VirtualFree`, exit 0. Query process heap with `GetProcessHeap`, exit 0 if nonzero. Allocate, fill 16 bytes with 1, exit 16. Allocate one page, copy four bytes from `.data`, sum them, exit 10.

**Other Win32 functions:** Call `GetCurrentProcessId`, exit `pid & 0x7F` (status varies). Call `QueryPerformanceCounter` (stub), exit 0. Call `CreatePipe` (stub), exit 0 (do not read/write).

Refer to `exercises/08-syscalls-files-mmap/README.md` for detailed descriptions and expected exit codes.
