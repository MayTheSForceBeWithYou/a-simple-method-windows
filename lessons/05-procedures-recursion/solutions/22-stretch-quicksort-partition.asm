; Exercise: 22-stretch-quicksort-partition
;
; Lomuto partition for [1,5,2,4]. Returns pivot index. Exit pivot index (2 or 3 depending).
; Expected exit: 2
;
.data
arr QWORD 1,5,2,4

.code
ex_22_stretch_quicksort_partition PROC
    sub rsp, 40
    lea rcx, arr
    xor rdx, rdx
    mov r8, 3
    call partition
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_22_stretch_quicksort_partition ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_quicksort_partition
    mov     rcx, rax
    call    ExitProcess
main ENDP

partition PROC
    push rbx
    push rsi
    push rdi
    mov r9, QWORD PTR [rcx+r8*8]
    mov rax, rdx
    dec rax
    mov r10, rdx
loop_part:
    cmp r10, r8
    jge finish_part
    cmp QWORD PTR [rcx+r10*8], r9
    jg next_part
    inc rax
    mov rbx, QWORD PTR [rcx+rax*8]
    mov rsi, QWORD PTR [rcx+r10*8]
    mov QWORD PTR [rcx+rax*8], rsi
    mov QWORD PTR [rcx+r10*8], rbx
next_part:
    inc r10
    jmp loop_part
finish_part:
    inc rax
    mov rbx, QWORD PTR [rcx+rax*8]
    mov rsi, QWORD PTR [rcx+r8*8]
    mov QWORD PTR [rcx+rax*8], rsi
    mov QWORD PTR [rcx+r8*8], rbx
    pop rdi
    pop rsi
    pop rbx
    ret
partition ENDP
END
