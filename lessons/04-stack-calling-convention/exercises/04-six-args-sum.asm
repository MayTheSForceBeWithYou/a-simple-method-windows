; Exercise 04: six args sum (Win32 port)
;
; Function sum6(a,b,c,d,e,f) -> RAX. MS x64: RCX, RDX, R8, R9, [RSP+32], [RSP+40]
; Call with 1,2,3,4,5,6; exit with 21.
;
; Build: ml64 /c /Fo04-six-args-sum.obj 04-six-args-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-six-args-sum.exe 04-six-args-sum.obj kernel32.lib
; Expected: exit code 21

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement sum6 that sums RCX, RDX, R8, R9, [RSP+32], [RSP+40]
.ERR <TODO: Implement sum6 PROC with 6 arguments>

main PROC FRAME
    sub rsp, 56                ; Shadow (32) + 2 stack args (16) + alignment (8)
    .allocstack 56
    .endprolog
    
    ; Args 5 and 6 on stack
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 6
    
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    call sum6
    mov rcx, rax
    call ExitProcess
main ENDP
END
