; 01-buffer-append.asm
;
; Purpose: Demonstrate buffer append operation
; Expected exit code: 3
; Expected stdout: (none)
;
; Core buffer primitive: append byte to end

.DATA?
buffer DB 256 DUP(?)
buf_len QWORD ?
cursor QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    lea     r10, buffer
    ; Initialize empty buffer
    mov     buf_len, 0
    mov     cursor, 0
    
    ; Append 'A'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'A'
    inc     buf_len
    
    ; Append 'B'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'B'
    inc     buf_len
    
    ; Append 'C'
    mov     rax, buf_len
    mov     BYTE PTR [r10+rax], 'C'
    inc     buf_len
    
    ; Exit with buf_len (3)
    mov     ecx, DWORD PTR buf_len
    call    ExitProcess
main ENDP

END
