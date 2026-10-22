; Exercise 10: nested if
;
; rax=7. If rax>0 and rax<10 exit 1 else 0.
;
; Build: ml64 /c 10-nested-if.asm && link /OUT:10-nested-if.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-nested-if.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_10_nested_if PROC
    sub rsp, 40
    mov rax, 7
    cmp rax, 0
    jle no
    cmp rax, 10
    jge no
    mov rcx, 1
    jmp L_done
no:
    xor rcx, rcx
L_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_nested_if ENDP
main PROC
    sub     rsp, 40
    call    ex_10_nested_if
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
