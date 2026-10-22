; Exercise: 27-print-digits-loop
;
; Print "01234\n" using a loop that stores digits into a buffer then one write. Exit 0.
; Expected exit: 0
;
.data?
buf BYTE 6 DUP(?)
written DWORD ?
hStdOut QWORD ?

.code
ex_27_print_digits_loop PROC
    sub rsp, 56
    xor r8, r8
loop_start:
    cmp r8, 5
    jge write_buf
    mov rax, r8
    add rax, '0'
    lea r11, [buf]
    mov BYTE PTR [r11+r8], al
    inc r8
    jmp loop_start
write_buf:
    lea r11, [buf]
    mov BYTE PTR [r11+5], 10
    
    ; Get stdout
    mov rcx, -11
    call GetStdHandle
    lea r11, [hStdOut]
    mov QWORD PTR [r11], rax
    
    ; Write buffer
    lea r11, [hStdOut]
    mov rcx, QWORD PTR [r11]
    lea rdx, [buf]
    mov r8d, 6
    lea r9, [written]
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_27_print_digits_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_27_print_digits_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
