; 02-scan-ident.asm: Scan identifier length, exit with length
; Expected: "foo" → exit 3
.DATA
source DB "foo", 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rsi, source
    xor rcx, rcx
scan_loop:
    movzx rax, BYTE PTR [rsi + rcx]
    cmp rax, 'a'
    jb done
    cmp rax, 'z'
    ja done
    inc rcx
    jmp scan_loop
done:
    mov ecx, ecx
    call ExitProcess
main ENDP
END
