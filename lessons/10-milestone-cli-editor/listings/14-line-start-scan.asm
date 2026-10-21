; Listing 14: Scan backward for line start (LESSON.md block 14)
;
; Purpose: Find line start index for cursor in buffer with newlines.
; Expected exit code: 3
; Expected stdout: (none)

.DATA
buf BYTE "ab", 10, "cd", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     rsi, 4
    mov     rcx, rsi
scan:
    test    rcx, rcx
    jz      done
    dec     rcx
    cmp     BYTE PTR buf[rcx], 10
    jne     scan
    inc     rcx
done:
    mov     ecx, ecx
    call    ExitProcess
main ENDP

END
