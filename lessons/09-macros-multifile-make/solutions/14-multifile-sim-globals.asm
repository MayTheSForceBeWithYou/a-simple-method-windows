; Exercise: 14-multifile-sim-globals
;
; Simulate module: PUBLIC helper_add; call with 20,22 exit 42.
; Expected exit: 42
;
.code
ex_14_multifile_sim_globals PROC
    sub rsp, 40
    
    mov rcx, 20
    mov rdx, 22
    call helper_add
    
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_14_multifile_sim_globals ENDP
main PROC
    sub     rsp, 40
    call    ex_14_multifile_sim_globals
    mov     rcx, rax
    call    ExitProcess
main ENDP

helper_add PROC
    ; MS x64 ABI: args in RCX, RDX
    mov rax, rcx
    add rax, rdx
    ret
helper_add ENDP
END
