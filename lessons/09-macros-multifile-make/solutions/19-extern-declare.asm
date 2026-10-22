; Exercise 19: extern declare
;
; EXTERN for multi-file; local call exit 9.
;
; Build: ml64 /c 19-extern-declare.asm && link /OUT:19-extern-declare.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-extern-declare.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

; In multi-file: EXTERN foo:PROC / PUBLIC foo

.code

ex_19_extern_declare PROC
call foo
    mov rcx, rax
    mov     eax, rax
    ret
ex_19_extern_declare ENDP
main PROC
    sub     rsp, 40
    call    ex_19_extern_declare
    mov     rcx, rax
    call    ExitProcess
main ENDP

foo PROC
    mov rax, 9
    ret
foo ENDP
END
