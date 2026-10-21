; Listing 08: Walk linked list and sum values (LESSON.md block 8)
; Expected exit: 12
; Expected stdout: (none)

.DATA
n3 DQ 5, 0
n2 DQ 4, n3
n1 DQ 3, n2

.CODE
EXTRN ExitProcess:PROC

main PROC
    lea     rsi, n1
    xor     rdi, rdi
walk:
    test    rsi, rsi
    jz      done
    add     rdi, [rsi]
    mov     rsi, [rsi+8]
    jmp     walk
done:
    mov     ecx, edi
    call    ExitProcess
main ENDP
END
