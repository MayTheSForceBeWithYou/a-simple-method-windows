; Calculate delta time, exit with dt
; Expected exit: 42
; Expected stdout: (none)
.DATA?
prev_time QWORD ?
curr_time QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov prev_time, 100
    mov curr_time, 142
    mov rax, curr_time
    sub rax, prev_time
    mov ecx, eax
    call ExitProcess
main ENDP
END
