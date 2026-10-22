; Exercise 17: macro stringize
;
; MASM text macro: write 'Q' and newline exit 0.
;
; Build: ml64 /c 17-macro-stringize.asm && link /OUT:17-macro-stringize.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-macro-stringize.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "Q\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "Q", 10

.data?
written DWORD ?

.code
ex_17_macro_stringize PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message
    mov rcx, rax
    lea rdx, msg
    mov r8d, 2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    call ExitProcess
    mov     eax, 0
    add     rsp, 56
    ret
ex_17_macro_stringize ENDP
main PROC
    sub     rsp, 40
    call    ex_17_macro_stringize
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
