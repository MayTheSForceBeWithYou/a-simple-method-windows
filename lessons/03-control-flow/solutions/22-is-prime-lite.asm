; Exercise 22: is prime lite
;
; Trial divide n=11 by 2..sqrt-ish (2..10). Exit 1 if prime else 0.
;
; Build: ml64 /c 22-is-prime-lite.asm && link /OUT:22-is-prime-lite.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-is-prime-lite.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov r8, 11
    mov r9, 2
loop_start:
    cmp r9, r8
    jge prime
    mov rax, r8
    xor rdx, rdx
    div r9
    cmp rdx, 0
    je composite
    inc r9
    jmp loop_start
composite:
    xor rcx, rcx
    jmp L_done
prime:
    mov rcx, 1
L_done:
    call ExitProcess
main ENDP
END
