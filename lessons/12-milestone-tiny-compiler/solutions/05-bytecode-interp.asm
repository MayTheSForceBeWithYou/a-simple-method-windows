; Exercise 05: bytecode interp
;
; Bytes: LOAD 4, LOAD 5, ADD, HALT. Exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.data
vmcode BYTE 1,4, 1,5, 2, 0

.data?
stack QWORD 8 DUP(?)
sp_ QWORD ?

.code
ex_05_bytecode_interp PROC
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
    cmp rax, 2
    je vm_add
    jmp vm_halt
vm_load:
    movzx rax, BYTE PTR [rsi]
    inc rsi
    mov rcx, QWORD PTR [sp_]
    lea r11, [stack]
    mov QWORD PTR [r11+rcx*8], rax
    inc QWORD PTR [sp_]
    jmp loop_vm
vm_add:
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stack]
    mov rax, QWORD PTR [r11+rcx*8]
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stack]
    add rax, QWORD PTR [r11+rcx*8]
    lea r11, [stack]
    mov QWORD PTR [r11+rcx*8], rax
    inc QWORD PTR [sp_]
    jmp loop_vm
vm_halt:
    dec QWORD PTR [sp_]
    mov rcx, QWORD PTR [sp_]
    lea r11, [stack]
        mov     eax, QWORD PTR [r11+rcx*8]
    ret
    add     rsp, 40
ex_05_bytecode_interp ENDP
main PROC
    call    ex_05_bytecode_interp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
