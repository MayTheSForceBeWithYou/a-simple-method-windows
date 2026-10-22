; Exercise 10: len equ
;
; Define string "equ works\n" with BYTE; length via EQU $ - label. Write it; exit 0.
;
; Build: ml64 /c 10-len-equ.asm && link /OUT:10-len-equ.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-len-equ.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "equ works", 13, 10
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_10_len_equ PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
        mov     eax, 0
    ret
    add     rsp, 56
ex_10_len_equ ENDP
main PROC
    call    ex_10_len_equ
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
