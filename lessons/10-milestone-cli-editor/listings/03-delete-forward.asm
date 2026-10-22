; 03-delete-forward.asm
;
; Purpose: Delete character at cursor (shift tail leftward)
; Expected exit code: 2
; Expected stdout: (none)
;
; Demonstrates: Delete-forward operation with tail shift

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Setup: "ABC" with cursor at 1
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'B'
    mov     BYTE PTR [r10+2], 'C'
    mov     buf_len, 3
    mov     cursor, 1
    
    ; Delete byte at cursor (delete 'B')
    ; Shift tail leftward
    mov     rcx, cursor
shift_loop:
    inc     rcx
    cmp     rcx, buf_len
    jge     shift_done
    mov     al, BYTE PTR [r10+rcx]
    mov     BYTE PTR [r10+rcx-1], al
    jmp     shift_loop
    
shift_done:
    dec     buf_len
    ; Buffer now contains "AC" (buf_len 2)
    
    ; Exit with buf_len (2)
    mov     ecx, DWORD PTR buf_len
    call    ExitProcess
main ENDP

END
