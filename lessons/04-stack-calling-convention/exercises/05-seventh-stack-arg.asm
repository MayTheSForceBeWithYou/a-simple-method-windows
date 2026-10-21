; Exercise 05: seventh stack arg (Win32 port)
;
; sum7 uses 7 args: RCX, RDX, R8, R9, [RSP+32], [RSP+40], [RSP+48]. Pass 1..7; exit 28.
;
; Build: ml64 /c /Fo05-seventh-stack-arg.obj 05-seventh-stack-arg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-seventh-stack-arg.exe 05-seventh-stack-arg.obj kernel32.lib
; Expected: exit code 28

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement sum7(a,b,c,d,e,f,g) summing all 7 args

main PROC FRAME
    sub rsp, 64                ; Shadow (32) + 3 stack args (24) + alignment (8)
    .allocstack 64
    .endprolog
    
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 6
    mov QWORD PTR [rsp+48], 7
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    call sum7
    mov rcx, rax
    call ExitProcess
main ENDP
END
