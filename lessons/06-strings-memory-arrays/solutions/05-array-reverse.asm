; Exercise 05: array reverse
; Reverse [1,2,3,4] in place; exit first=4.
; Expected exit: 4

EXTERN ExitProcess:PROC

.data
arr QWORD 1,2,3,4

.code

ex_05_array_reverse PROC
lea rcx, arr
    mov rdx, 4
    call rev_array
    mov rcx, arr
    mov     eax, ecx
    ret
ex_05_array_reverse ENDP
main PROC
    sub     rsp, 40
    call    ex_05_array_reverse
    mov     rcx, rax
    call    ExitProcess
main ENDP

rev_array PROC
    xor r8, r8
    mov r9, rdx
    dec r9
loop_rev:
    cmp r8, r9
    jge done_rev
    mov rax, QWORD PTR [rcx+r8*8]
    mov r10, QWORD PTR [rcx+r9*8]
    mov QWORD PTR [rcx+r8*8], r10
    mov QWORD PTR [rcx+r9*8], rax
    inc r8
    dec r9
    jmp loop_rev
done_rev:
    ret
rev_array ENDP
END
