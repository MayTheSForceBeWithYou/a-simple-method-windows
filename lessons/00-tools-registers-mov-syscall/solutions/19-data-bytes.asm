; Exercise: 19-data-bytes
;
; Emit bytes 048h 069h 00Ah (Hi newline) using BYTE. Write them; exit 0.
; Expected exit: 0
;
.data
msg BYTE 048h, 069h, 00Dh, 00Ah
msg_len EQU $ - msg

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_19_data_bytes PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write message
    mov rcx, hStdOut
    lea rdx, msg
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_19_data_bytes ENDP
main PROC
    sub     rsp, 40
    call    ex_19_data_bytes
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
