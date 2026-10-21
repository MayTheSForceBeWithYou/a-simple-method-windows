; Listing 07: Insert in middle with tail shift (LESSON.md block 7)
;
; Purpose: Shift tail right and insert 'B' at cursor.
; Expected exit code: 66
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buf
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'C'
    mov     len, 2
    mov     cur, 1
    mov     rcx, len
shift:
    cmp     rcx, cur
    jle     done_shift
    mov     al, BYTE PTR [r10+rcx-1]
    mov     BYTE PTR [r10+rcx], al
    dec     rcx
    jmp     shift
done_shift:
    mov     rax, cur
    mov     BYTE PTR [r10+rax], 'B'
    inc     len
    inc     cur
    mov     ecx, 66
    call    ExitProcess
main ENDP

END
