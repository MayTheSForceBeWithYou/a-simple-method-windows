; Exercise 23: collatz steps
;
; Collatz steps for n=6 until 1: 6->3->10->5->16->8->4->2->1 = 8 steps. Exit 8.
;
; Build: ml64 /c 23-collatz-steps.asm && link /OUT:23-collatz-steps.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-collatz-steps.obj kernel32.lib
;
; Expected exit: 8

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 6
    xor rcx, rcx
loop_start:
    cmp rax, 1
    je done
    inc rcx
    test rax, 1
    jnz odd
    shr rax, 1
    jmp loop_start
odd:
    imul rax, 3
    add rax, 1
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
