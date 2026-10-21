; Listing 20: Insert-middle shift with jl exit test (LESSON.md block 20)
;
; Purpose: Shift loop using jl; store 'B' at index 1; len becomes 3.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
len QWORD ?
cur QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     BYTE PTR buf[0], 'A'
    mov     BYTE PTR buf[1], 'C'
    mov     len, 2
    mov     cur, 1
    mov     rcx, len
shift:
    cmp     rcx, cur
    jl      put_byte
    mov     al, BYTE PTR buf[rcx-1]
    mov     BYTE PTR buf[rcx], al
    dec     rcx
    jmp     shift
put_byte:
    mov     BYTE PTR buf[1], 'B'
    inc     len
    mov     ecx, DWORD PTR len
    call    ExitProcess
main ENDP

END
