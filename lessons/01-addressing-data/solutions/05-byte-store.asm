; Exercise: 05-byte-store
;
; buf: 3 bytes. Store "O" and "K", write both + newline. Exit 0.
; Expected exit: 0
;
.data
buf BYTE 0, 0, 13, 10

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_05_byte_store PROC
    sub rsp, 56
    
    ; Store characters
    mov BYTE PTR [buf], 'O'
    mov BYTE PTR [buf+1], 'K'
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write buffer
    mov rcx, hStdOut
    lea rdx, buf
    mov r8d, 4
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_05_byte_store ENDP
main PROC
    sub     rsp, 40
    call    ex_05_byte_store
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
