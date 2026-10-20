; 02-insert-middle.asm
;
; Purpose: Insert character in middle of buffer with tail shift
; Expected exit code: 66 (ASCII 'B')
; Expected stdout: (none)
;
; Demonstrates: Shifting tail rightward to make room for insertion

.DATA?
buffer DB 256 DUP(?)
length QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; Setup: "AC" with cursor at 1
    mov     BYTE PTR buffer[0], 'A'
    mov     BYTE PTR buffer[1], 'C'
    mov     length, 2
    mov     cursor, 1
    
    ; Insert 'B' at cursor (index 1)
    ; Shift tail rightward
    mov     rcx, length
shift_loop:
    cmp     rcx, cursor
    jle     shift_done
    mov     al, buffer[rcx-1]
    mov     buffer[rcx], al
    dec     rcx
    jmp     shift_loop
    
shift_done:
    ; Store new byte at cursor
    mov     rax, cursor
    mov     BYTE PTR buffer[rax], 'B'
    inc     length
    inc     cursor
    
    ; Buffer now contains "ABC"
    ; Exit with 'B' (66)
    mov     ecx, 66
    call    ExitProcess
main ENDP

END
