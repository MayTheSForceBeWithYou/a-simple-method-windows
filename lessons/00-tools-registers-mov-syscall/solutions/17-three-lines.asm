; Exercise: 17-three-lines
;
; Print "one\n" "two\n" "three\n". Exit 0.
; Expected exit: 0
;
.data
l1 BYTE "one", 13, 10
n1 EQU $ - l1
l2 BYTE "two", 13, 10
n2 EQU $ - l2
l3 BYTE "three", 13, 10
n3 EQU $ - l3

.data?
written DWORD ?
hStdOut QWORD ?

.code
ex_17_three_lines PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    mov hStdOut, rax
    
    ; Write "one\n"
    mov rcx, hStdOut
    lea rdx, l1
    mov r8d, n1
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Write "two\n"
    mov rcx, hStdOut
    lea rdx, l2
    mov r8d, n2
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Write "three\n"
    mov rcx, hStdOut
    lea rdx, l3
    mov r8d, n3
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    mov     eax, 0
    add     rsp, 56
    ret
ex_17_three_lines ENDP
main PROC
    sub     rsp, 40
    call    ex_17_three_lines
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
