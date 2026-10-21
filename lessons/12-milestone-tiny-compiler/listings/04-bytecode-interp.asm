; 04-bytecode-interp.asm: Simple bytecode interpreter
; Opcodes: 1=LOAD_IMM, 2=ADD, 3=HALT
; Program: LOAD 10, LOAD 20, ADD, HALT → exit 30
.DATA
bytecode DB 1, 10, 1, 20, 2, 3
.DATA?
ip QWORD ?
acc QWORD ?
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub     rsp, 32
    lea rax, bytecode
    mov ip, rax
    xor rax, rax
    mov acc, rax
interp_loop:
    mov rbx, ip
    movzx rax, BYTE PTR [rbx]
    cmp rax, 1
    je op_load
    cmp rax, 2
    je op_add
    cmp rax, 3
    je op_halt
op_load:
    inc QWORD PTR ip
    mov rbx, ip
    movzx rax, BYTE PTR [rbx]
    mov acc, rax
    inc QWORD PTR ip
    jmp interp_loop
op_add:
    mov rax, acc
    add rax, 10
    mov acc, rax
    inc QWORD PTR ip
    jmp interp_loop
op_halt:
    mov rax, acc
    mov ecx, eax
    call ExitProcess
main ENDP
END
