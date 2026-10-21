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
main PROC
    sub rsp, 40
    
    call foo
    mov rcx, rax
    call ExitProcess
main ENDP

foo PROC
    mov rax, 9
    ret
foo ENDP
END
