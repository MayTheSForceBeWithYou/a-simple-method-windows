; Exercise: 15-makefile-phony-doc
;
; Documents build script; program exits 0. Read comment about build targets.
; Expected exit: 0
;
.code
ex_15_makefile_phony_doc PROC
    sub rsp, 40
    mov rcx, 0
    mov     eax, 0
    add     rsp, 40
    ret
ex_15_makefile_phony_doc ENDP
main PROC
    sub     rsp, 40
    call    ex_15_makefile_phony_doc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
