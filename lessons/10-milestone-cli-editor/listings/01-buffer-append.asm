; 01-buffer-append.asm
;
; Purpose: Demonstrate buffer append operation
; Expected exit code: 3
; Expected stdout: (none)
;
; Core buffer primitive: append byte to end

.DATA?
buffer DB 256 DUP(?)
length QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    ; Initialize empty buffer
    mov     length, 0
    mov     cursor, 0
    
    ; Append 'A'
    mov     rax, length
    mov     BYTE PTR buffer[rax], 'A'
    inc     length
    
    ; Append 'B'
    mov     rax, length
    mov     BYTE PTR buffer[rax], 'B'
    inc     length
    
    ; Append 'C'
    mov     rax, length
    mov     BYTE PTR buffer[rax], 'C'
    inc     length
    
    ; Exit with length (3)
    mov     ecx, DWORD PTR length
    call    ExitProcess
main ENDP

END
