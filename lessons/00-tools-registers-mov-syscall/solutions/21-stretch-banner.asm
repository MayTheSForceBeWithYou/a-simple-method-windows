; Exercise 21: stretch banner
;
; STRETCH: Print a 3-line ASCII banner, exit 0.
;
; Build: ml64 /c 21-stretch-banner.asm && link /OUT:21-stretch-banner.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-stretch-banner.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
banner BYTE "============", 13, 10
       BYTE "  ASM 00 OK ", 13, 10
       BYTE "============", 13, 10
banner_len EQU $ - banner

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_21_stretch_banner PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write banner
    mov rcx, hStdOut
    lea rdx, banner
    mov r8d, banner_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_21_stretch_banner ENDP
main PROC
    sub     rsp, 40
    call    ex_21_stretch_banner
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
