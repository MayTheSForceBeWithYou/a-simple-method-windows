; Listing 07: Whole-word keyword match for "let"
; Expected exit: 1
; Expected stdout: (none)

.DATA
kw BYTE "let", 0
src BYTE "let", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rsi
    push    rdi
    sub     rsp, 40
    lea     rsi, src
    lea     rdi, kw
    mov     rcx, 3
    cld
    repe    cmpsb
    jne     no_match
    cmp     BYTE PTR [src + 3], 0
    jne     no_match
    mov     ecx, 1
    jmp     done
no_match:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
