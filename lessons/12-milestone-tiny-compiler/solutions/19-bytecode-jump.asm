; Exercise 19: bytecode jump
;
; Bytecode: JMP +2 over LOAD 99, LOAD 5, HALT; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.data
vmcode BYTE 3,2, 1,99, 1,5, 0

.data?
stk QWORD 4 DUP(?)
sp_ QWORD ?

.code
ex_19_bytecode_jump PROC
    sub rsp, 40
    mov QWORD PTR [sp_], 0
    lea rsi, [vmcode]
loop_vm:
    movzx rax, BYTE PTR [rsi]
    inc rsi
    cmp rax, 0
    je vm_halt
    cmp rax, 1
    je vm_load
    cmp rax, 3
    je vm_jmp
    jmp vm_halt
vm_load:
    movzx rax, BYTE PTR [rsi]
    inc rsi
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
    mov QWORD PTR [r11+rcx*8], rax
    inc QWORD PTR [sp_]
    jmp loop_vm
vm_jmp:
    movzx rax, BYTE PTR [rsi]
    inc rsi
    add rsi, rax
    jmp loop_vm
vm_halt:
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stk]
        mov     eax, QWORD PTR [r11+rcx*8]
    ret

ex_19_bytecode_jump ENDP
main PROC
    call    ex_19_bytecode_jump
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
