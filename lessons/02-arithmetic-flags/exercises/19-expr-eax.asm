; Exercise 19: expr eax
;
; Compute (3+5)*7-8 into rcx (48).
;
; Build: ml64 /c 19-expr-eax.asm && link /OUT:19-expr-eax.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-expr-eax.obj kernel32.lib
;
; Expected exit: 48


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_19_expr_eax:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_expr_eax in this file.
    call    ex_19_expr_eax
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
