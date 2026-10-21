; Listing 06: Bytecode relative jump (LESSON.md block 6)
; Expected exit: 0
; Expected stdout: (none)

.DATA
code DB 3, 2, 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, code
    movzx   rax, BYTE PTR [rsi]
    inc     rsi
    add     rsi, rax
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
