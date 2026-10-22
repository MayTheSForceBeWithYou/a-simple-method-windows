; Exercise 22: stretch undo stack
;
; STRETCH: push op code 1 then 2; pop once; exit top 1.
;
; Build: ml64 /c 22-stretch-undo-stack.asm && link /OUT:22-stretch-undo-stack.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-undo-stack.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.data?
ustk QWORD 8 DUP(?)
usp QWORD ?

.code

ex_22_stretch_undo_stack PROC
sub rsp, 40
    
    mov QWORD PTR [usp], 0
    
    ; Push 1
    mov rcx, [usp]
    lea rdx, ustk
    mov QWORD PTR [rdx+rcx*8], 1
    inc QWORD PTR [usp]
    
    ; Push 2
    mov rcx, [usp]
    mov QWORD PTR [rdx+rcx*8], 2
    inc QWORD PTR [usp]
    
    ; Pop
    dec QWORD PTR [usp]
    
    ; Get top (which is now 1)
    mov rcx, [usp]
    dec rcx
    mov     eax, 1
    ret
ex_22_stretch_undo_stack ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_undo_stack
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
