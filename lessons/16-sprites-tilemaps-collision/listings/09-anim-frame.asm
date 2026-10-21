; Listing 09: Animation frame from tick counter
; Expected exit: 2
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    mov eax, 25
    mov ecx, 10
    xor edx, edx
    div ecx
    mov ecx, eax
    call ExitProcess
main ENDP
END
