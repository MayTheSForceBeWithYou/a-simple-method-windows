; Exercise 03: macro write
;
; Macro write_stdout msg,len; print 'M\n'.
;
; Build: ml64 /c 03-macro-write.asm && link /OUT:03-macro-write.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-macro-write.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "M\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

; MASM macro for writing to stdout
write_stdout MACRO msg, len
    LOCAL written, hStdOut
    .data?
    written DWORD ?
    hStdOut QWORD ?
    .code
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
ENDM

.data
m BYTE "M", 10

.code
ex_03_macro_write PROC
    sub rsp, 56
    
    write_stdout m, 2
    
    ; Exit 0
        mov     eax, 0
    ret
    add     rsp, 56
ex_03_macro_write ENDP
main PROC
    call    ex_03_macro_write
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
