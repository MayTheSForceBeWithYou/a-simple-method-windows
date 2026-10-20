; 01-scan-number.asm: Scan multi-digit decimal number, exit with value
; Expected: "42" → exit 42
.DATA
source DB "42", 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    lea rsi, source
    xor rdi, rdi
next_digit:
    movzx rax, BYTE PTR [rsi]
    test rax, rax
    jz done
    sub rax, '0'
    imul rdi, 10
    add rdi, rax
    inc rsi
    jmp next_digit
done:
    mov ecx, edi
    call ExitProcess
main ENDP
END
