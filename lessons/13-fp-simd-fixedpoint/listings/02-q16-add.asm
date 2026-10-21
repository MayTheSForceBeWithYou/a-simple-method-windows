; 02-q16-add.asm: Add two Q16.16 values (1.5 + 2.5 = 4.0)
; Expected exit: 4
; Expected stdout: (none)
; Exit 4
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, (1 SHL 16) + (1 SHL 15)
    mov ebx, (2 SHL 16) + (1 SHL 15)
    add eax, ebx
    shr eax, 16
    mov ecx, eax
    call ExitProcess
main ENDP
END
