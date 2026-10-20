; 01-token-classify.asm: Classify byte as digit, exit 1 if digit else 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov al, '7'
    cmp al, '0'
    jb not_digit
    cmp al, '9'
    ja not_digit
    mov ecx, 1
    jmp done
not_digit:
    xor ecx, ecx
done:
    call ExitProcess
main ENDP
END
