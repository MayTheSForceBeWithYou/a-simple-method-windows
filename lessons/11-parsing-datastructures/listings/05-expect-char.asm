; Listing 05: Parser expect helper (LESSON.md block 5)
; Expected exit: 1
; Expected stdout: (none)

.DATA
input DB "(1)", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     rsi, input
    mov     al, '('
    cmp     BYTE PTR [rsi], al
    jne     error
    inc     rsi
    mov     ecx, 1
    jmp     done
error:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
