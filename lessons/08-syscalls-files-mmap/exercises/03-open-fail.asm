; Exercise: 03-open-fail
;
; Exercise 03: open fail
; open nonexistent path; if CreateFileA returns INVALID_HANDLE_VALUE exit 1 else 0. Expect 1.
;
; Contract: implement `ex_03_open_fail` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 03-open-fail.asm
;
; Try to open a missing file, exit 1 on failure.
;
; Task: Call CreateFileA on "/no/such/file" with OPEN_EXISTING.
;       Check for INVALID_HANDLE_VALUE (-1), exit 1 if failed.
;
; Hint: CreateFileA returns INVALID_HANDLE_VALUE (-1) on error.
;       Compare rax with -1: cmp rax, -1; je error

.DATA
filename DB "C:\no\such\file.txt", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_03_open_fail:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_open_fail in this file.
    call    ex_03_open_fail
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
