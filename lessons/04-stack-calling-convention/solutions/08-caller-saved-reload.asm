; Exercise 08: caller saved reload
;
; Put 5 in r10; call function that returns 1; add r10 — must save r10 (volatile). Exit 6.
;
; Build: ml64 /c 08-caller-saved-reload.asm && link /OUT:08-caller-saved-reload.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-caller-saved-reload.obj kernel32.lib
;
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
ex_08_caller_saved_reload PROC
    sub rsp, 40
    mov r10, 5
    push r10
    call one
    pop r10
    add rax, r10
        mov     eax, rax
    add     rsp, 40
    ret
ex_08_caller_saved_reload ENDP
main PROC
    call    ex_08_caller_saved_reload
    mov     rcx, rax
    call    ExitProcess
main ENDP

one PROC
    mov rax, 1
    mov r10, 999
    ret
one ENDP
END
