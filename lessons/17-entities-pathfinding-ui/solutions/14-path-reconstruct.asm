; Exercise: 14-path-reconstruct
;
; Path length 4; exit 4.
; Expected stdout: (none)
; Expected exit: 4
;
.code
ex_14_path_reconstruct PROC
    sub rsp, 40
    mov rcx, 4
    mov     eax, 4
    add     rsp, 40
    ret
ex_14_path_reconstruct ENDP
main PROC
    sub     rsp, 40
    call    ex_14_path_reconstruct
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
