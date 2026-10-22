; Spawn visitor entity, exit visitor count
; Expected exit: 1
; Expected stdout: (none)
.DATA?
visitor_count QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov visitor_count, 0
    inc visitor_count
    mov rax, visitor_count
    mov ecx, eax
    call ExitProcess
main ENDP
END
