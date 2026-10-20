; Exercise 28: gcd loop
;
; Euclid GCD(48,18)=6. Exit 6.
;
; Build: ml64 /c 28-gcd-loop.asm && link /OUT:28-gcd-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 28-gcd-loop.obj kernel32.lib
;
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 48
    mov rbx, 18
loop_start:
    cmp rbx, 0
    je done
    xor rdx, rdx
    div rbx
    mov rax, rbx
    mov rbx, rdx
    jmp loop_start
done:
    mov rcx, rax
    call ExitProcess
main ENDP
END
