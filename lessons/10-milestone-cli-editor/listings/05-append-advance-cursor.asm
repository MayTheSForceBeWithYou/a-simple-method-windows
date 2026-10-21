; Listing 05: Append byte and advance cursor (LESSON.md block 5)
;
; Purpose: Append 'A' at end and move cursor with length.
; Expected exit code: 1
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
    mov     len, 0
    mov     cur, 0
    mov     rax, len
    mov     BYTE PTR [r10+rax], 'A'
    inc     len
    inc     cur
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
