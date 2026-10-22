; 02-insert-middle.asm
;
; Purpose: Insert character in middle of buffer with tail shift
; Expected exit code: 66 (ASCII 'B')
; Expected stdout: (none)
;
; Demonstrates: Shifting tail rightward to make room for insertion

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Setup: "AC" with cursor at 1
    mov     BYTE PTR [r10+0], 'A'
    mov     BYTE PTR [r10+1], 'C'
    mov     buf_len, 2
    mov     cursor, 1
    
    ; Insert 'B' at cursor (index 1)
    ; Shift tail rightward
    mov     rcx, buf_len
shift_loop:
    cmp     rcx, cursor
    jle     shift_done
    mov     al, BYTE PTR [r10+rcx-1]
    mov     BYTE PTR [r10+rcx], al
    dec     rcx
    jmp     shift_loop
    
shift_done:
    ; Store new byte at cursor
    mov     rax, cursor
    mov     BYTE PTR [r10+rax], 'B'
    inc     buf_len
    inc     cursor
    
    ; Buffer now contains "ABC"
    ; Exit with 'B' (66)
    mov     ecx, 66
    call    ExitProcess
main ENDP

END
