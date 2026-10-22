; Exercise 10: macro syscall
;
; MACRO CALL_FUNC for calling ExitProcess; Print "K\n" exit 0.
;
; Build: ml64 /c 10-macro-syscall.asm && link /OUT:10-macro-syscall.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-macro-syscall.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "K\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

; Simple macro to encapsulate function calls
CALL_FUNC MACRO func
    call func
ENDM

.data
msg BYTE "K", 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_10_macro_syscall PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    CALL_FUNC GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    CALL_FUNC WriteFile
    
    ; Exit 0
    mov rcx, 0
    CALL_FUNC ExitProcess
    add     rsp, 56
ex_10_macro_syscall ENDP
main PROC
    call    ex_10_macro_syscall
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
