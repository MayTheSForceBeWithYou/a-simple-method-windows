; 03-delete-forward.asm
;
; Purpose: Delete character at cursor (shift tail leftward)
; Expected exit code: 2
; Expected stdout: (none)
;
; Demonstrates: Delete-forward operation with tail shift

.DATA?
buffer DB 256 DUP(?)
length QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    ; Setup: "ABC" with cursor at 1
    mov     BYTE PTR buffer[0], 'A'
    mov     BYTE PTR buffer[1], 'B'
    mov     BYTE PTR buffer[2], 'C'
    mov     length, 3
    mov     cursor, 1
    
    ; Delete byte at cursor (delete 'B')
    ; Shift tail leftward
    mov     rcx, cursor
shift_loop:
    inc     rcx
    cmp     rcx, length
    jge     shift_done
    mov     al, buffer[rcx]
    mov     buffer[rcx-1], al
    jmp     shift_loop
    
shift_done:
    dec     length
    ; Buffer now contains "AC" (length 2)
    
    ; Exit with length (2)
    mov     ecx, DWORD PTR length
    call    ExitProcess
main ENDP

END
