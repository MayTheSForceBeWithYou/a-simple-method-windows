; Exercise: 21-debug-fd-leak-pattern
;
; Exercise 21: debug fd pattern
; BUG: wrong handle for close. Fix open NUL and close; exit 0.
;
; Contract: implement `ex_21_debug_fd_leak_pattern` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 21-debug-fd-leak-pattern.asm
;
; Fix bug: Open file, forget to close it (intentional leak pattern for debugging).
; Expected exit: 0

.DATA
filename DB "NUL", 0

.CODE

EXTRN CreateFileA:PROC
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_fd_leak_pattern:PROC

open_no_close PROC
    sub rsp, 72
    lea rcx, filename
    mov rdx, 80000000h
    mov r8d, 1
    mov r9, 0
    mov QWORD PTR [rsp+32], 3
    mov QWORD PTR [rsp+40], 80h
    mov QWORD PTR [rsp+48], 0
    call CreateFileA
    ; BUG: missing CloseHandle — handle leaked
    xor eax, eax
    add rsp, 72
    ret
open_no_close ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_fd_leak_pattern in this file (open NUL and close).
    call    ex_21_debug_fd_leak_pattern
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
