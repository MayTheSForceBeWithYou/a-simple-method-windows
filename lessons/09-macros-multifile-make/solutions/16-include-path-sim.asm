; Exercise: 16-include-path-sim
;
; Define VERSION 3; exit VERSION.
; Expected exit: 3
;
.code
ex_16_include_path_sim PROC
    sub rsp, 40
    mov rcx, VERSION
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_include_path_sim ENDP
main PROC
    sub     rsp, 40
    call    ex_16_include_path_sim
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
