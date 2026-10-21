; Listing 09: Animation frame from tick counter
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC
main PROC
    mov eax, 25
    mov ecx, 10
    xor edx, edx
    div ecx
    mov ecx, eax
    call ExitProcess
main ENDP
END
