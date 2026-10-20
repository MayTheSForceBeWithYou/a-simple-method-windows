; Exercise 24: from scratch kill line
;
; FROM SCRATCH: "ab\ncd" kill from cur=0 to newline -> len becomes 3 ("\ncd"); exit 3.
;
; Build: ml64 /c 24-from-scratch-kill-line.asm && link /OUT:24-from-scratch-kill-line.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-kill-line.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
buf BYTE "ab", 10, "cd", 0

.data?
len QWORD ?
cur QWORD ?

.code
main PROC
    sub rsp, 32
    
    mov QWORD PTR [len], 5
    mov QWORD PTR [cur], 0
    
    ; Find newline
    mov rcx, 0
    lea rdx, buf
    
.f:
    cmp BYTE PTR [rdx+rcx], 10
    je .got
    inc rcx
    jmp .f
    
.got:
    ; Delete [0,rcx) - move from rcx onwards to start
    mov r8, rcx
    mov r9, [len]
    mov rdi, 0
    mov rsi, r8
    
.cpy:
    cmp rsi, r9
    jge .done
    
    movzx rax, BYTE PTR [rdx+rsi]
    mov BYTE PTR [rdx+rdi], al
    
    inc rsi
    inc rdi
    jmp .cpy
    
.done:
    mov [len], rdi
    mov rcx, [len]
    call ExitProcess
main ENDP
END
