; Exercise: 25-stretch-binsearch
;
; STRETCH: sorted QWORD 1,3,5,7,9. Binary search for 7; exit index 3.
; Expected exit: 3
;
.data
arr QWORD 1, 3, 5, 7, 9
n EQU 5

.code
ex_25_stretch_binsearch PROC
    sub rsp, 40
    xor r8, r8
    mov r9, n
    dec r9
    mov r10, 7
loop_start:
    cmp r8, r9
    jg miss
    mov rax, r8
    add rax, r9
    shr rax, 1
    mov rcx, rax
    lea r11, [arr]
    mov rdx, QWORD PTR [r11+rcx*8]
    cmp rdx, r10
    je found
    jl go_right
    mov r9, rcx
    dec r9
    jmp loop_start
go_right:
    mov r8, rcx
    inc r8
    jmp loop_start
found:
    mov rcx, r8
    jmp L_done
miss:
    mov rcx, 255
L_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_25_stretch_binsearch ENDP
main PROC
    sub     rsp, 40
    call    ex_25_stretch_binsearch
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
