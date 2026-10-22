; 21-debug-fd-leak-pattern.asm
;
; Fix bug: Open file, forget to close it (intentional leak pattern for debugging).
;
; Task: CreateFileA("NUL", GENERIC_READ, ...), intentionally do NOT close, exit 0.
;       Demonstrates resource leak (in real code, CloseHandle is required).
;
; Hint: Bug demonstration - normally you'd CloseHandle, but here we leak it.

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_fd_leak_pattern:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_fd_leak_pattern in this file.
    call    ex_21_debug_fd_leak_pattern
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
