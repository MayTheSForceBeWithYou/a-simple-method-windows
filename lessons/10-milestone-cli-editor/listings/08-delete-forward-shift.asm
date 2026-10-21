; Listing 08: Delete-forward tail shift (LESSON.md block 8)
;
; Purpose: Shift [r10+cur+1..len) left and decrement len.
; Expected exit code: 2
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
    mov     BYTE PTR [r10+1], 'B'
    mov     BYTE PTR [r10+2], 'C'
    mov     len, 3
    mov     cur, 1
    mov     rcx, cur
shift:
    inc     rcx
    cmp     rcx, len
    jge     done_shift
    mov     al, BYTE PTR [r10+rcx]
    mov     BYTE PTR [r10+rcx-1], al
    jmp     shift
done_shift:
    dec     len
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
