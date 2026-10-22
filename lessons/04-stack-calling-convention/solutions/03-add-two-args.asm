; Exercise 03: add two args
;
; Function add(rcx,rdx)->rax. Call with 10,32; exit 42.
;
; Build: ml64 /c 03-add-two-args.asm && link /OUT:03-add-two-args.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-add-two-args.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_03_add_two_args PROC
    sub rsp, 40
    mov rcx, 10
    mov rdx, 32
    call add2
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_03_add_two_args ENDP
main PROC
    sub     rsp, 40
    call    ex_03_add_two_args
    mov     rcx, rax
    call    ExitProcess
main ENDP

add2 PROC
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP
END
