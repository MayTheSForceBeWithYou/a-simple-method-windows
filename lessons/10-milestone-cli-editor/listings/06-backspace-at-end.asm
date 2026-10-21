; Listing 06: Backspace when cursor at end (LESSON.md block 6)
;
; Purpose: Decrement len and cur when cur == len at end of buffer.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     BYTE PTR buf[0], 'X'
    mov     len, 1
    mov     cur, 1
    cmp     cur, 0
    je      done
    mov     rax, cur
    cmp     rax, len
    jne     done
    dec     len
    dec     cur
done:
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
