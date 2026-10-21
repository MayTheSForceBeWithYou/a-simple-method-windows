; Listing 20: Copy lexeme bytes and exit length (LESSON.md)
; Expected exit: 3
; Expected stdout: (none)

.DATA
src BYTE "let", 0

.DATA?
dst BYTE 8 DUP(?)
lex_len QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, src
    lea     rdi, dst
    xor     rcx, rcx
copy:
    movzx   eax, BYTE PTR [rsi + rcx]
    test    al, al
    jz      done_copy
    mov     BYTE PTR [rdi + rcx], al
    inc     rcx
    jmp     copy

done_copy:
    mov     lex_len, rcx
    mov     ecx, DWORD PTR lex_len
    call    ExitProcess
main ENDP
END
