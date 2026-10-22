; Exercise 05: imul three
;
; Set rcx=6 then imul rcx,7. Exit 42.
;
; Build: ml64 /c 05-imul-three.asm && link /OUT:05-imul-three.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-imul-three.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_05_imul_three PROC
    sub rsp, 40
    mov rcx, 6
    imul rcx, 7
    mov     eax, 42
    ret
ex_05_imul_three ENDP
main PROC
    call    ex_05_imul_three
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
