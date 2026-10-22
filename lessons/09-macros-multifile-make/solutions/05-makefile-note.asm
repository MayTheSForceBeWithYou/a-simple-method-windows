; Exercise: 05-makefile-note
;
; Single-file stand-in: exit 0. (Real multi-file would use build script.)
; Expected exit: 0
;
.code
ex_05_makefile_note PROC
    sub rsp, 40
    mov rcx, 0
    mov     eax, 0
    add     rsp, 40
    ret
ex_05_makefile_note ENDP
main PROC
    sub     rsp, 40
    call    ex_05_makefile_note
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
