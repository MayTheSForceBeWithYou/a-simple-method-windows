; Exercise 24: stretch variadic sum (Win32 port)
; STRETCH: sum_n(n, ...) where RCX=n, then n qwords on stack. sum_n(4, 3,4,5,6)=18.
; Build: ml64 /c /Fo24-stretch-variadic-sum.obj 24-stretch-variadic-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:24-stretch-variadic-sum.exe 24-stretch-variadic-sum.obj kernel32.lib
; Expected: exit code 18

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement variadic sum_n(RCX=count, stack args)

main PROC FRAME
    sub rsp, 72                ; Shadow + args + alignment
    .allocstack 72
    .endprolog
    
    mov QWORD PTR [rsp+32], 3
    mov QWORD PTR [rsp+40], 4
    mov QWORD PTR [rsp+48], 5
    mov QWORD PTR [rsp+56], 6
    mov rcx, 4
    call sum_n
    mov rcx, rax
    call ExitProcess
main ENDP
END
