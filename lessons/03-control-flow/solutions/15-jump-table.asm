; Exercise 15: jump table
;
; rax=1. Jump table of 3 cases setting rcx to 10/20/30. Exit 20.
;
; Build: ml64 /c 15-jump-table.asm && link /OUT:15-jump-table.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-jump-table.obj kernel32.lib
;
; Expected exit: 20

EXTERN ExitProcess:PROC

.const
jt QWORD case0, case1, case2

.code
main PROC
    sub rsp, 32
    mov rax, 1
    jmp QWORD PTR [jt+rax*8]
case0:
    mov rcx, 10
    jmp done
case1:
    mov rcx, 20
    jmp done
case2:
    mov rcx, 30
done:
    call ExitProcess
main ENDP
END
