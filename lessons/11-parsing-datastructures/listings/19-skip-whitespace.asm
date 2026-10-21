; Listing 19: Skip ASCII spaces, parse digit (LESSON.md)
; Expected exit: 7
; Expected stdout: (none)

.DATA
src BYTE "  ", "7", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, src
skip:
    movzx   eax, BYTE PTR [rsi]
    cmp     al, 32
    jne     at_digit
    inc     rsi
    jmp     skip

at_digit:
    movzx   ecx, al
    sub     ecx, '0'
    call    ExitProcess
main ENDP
END
