; Exercise 04: tree sum flat
; Binary heap array [1,2,3,4,5]. Recursively sum. Exit 15.
; Expected exit: 15

EXTERN ExitProcess:PROC

.data
heap QWORD 1,2,3,4,5
heap_n EQU 5

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    call heap_sum
    mov rcx, rax
    call ExitProcess
main ENDP

heap_sum PROC
    cmp rcx, heap_n
    jge zero_sum
    push rbx
    push rcx
    sub rsp, 32
    lea r11, [heap]
    mov rax, QWORD PTR [r11+rcx*8]
    mov rbx, rax
    mov rax, rcx
    imul rax, 2
    inc rax
    mov rcx, rax
    call heap_sum
    add rbx, rax
    mov rcx, QWORD PTR [rsp+32]
    imul rcx, 2
    add rcx, 2
    call heap_sum
    add rax, rbx
    add rsp, 32
    pop rcx
    pop rbx
    ret
zero_sum:
    xor rax, rax
    ret
heap_sum ENDP
END
