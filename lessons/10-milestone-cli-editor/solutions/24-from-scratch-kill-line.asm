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

ex_24_from_scratch_kill_line PROC
mov QWORD PTR [len], 5
    mov QWORD PTR [cur], 0
    
    ; Find newline
    mov rcx, 0
    lea rdx, buf
    
L_f:
    cmp BYTE PTR [rdx+rcx], 10
    je L_got
    inc rcx
    jmp L_f
    
L_got:
    ; Delete [0,rcx) - move from rcx onwards to start
    mov r8, rcx
    mov r9, [len]
    mov rdi, 0
    mov rsi, r8
    
L_cpy:
    cmp rsi, r9
    jge L_done
    
    movzx rax, BYTE PTR [rdx+rsi]
    mov BYTE PTR [rdx+rdi], al
    
    inc rsi
    inc rdi
    jmp L_cpy
    
L_done:
    mov [len], rdi
    mov rcx, [len]
    mov     eax, ecx
    ret
ex_24_from_scratch_kill_line ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_kill_line
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
