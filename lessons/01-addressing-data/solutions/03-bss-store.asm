; Exercise: 03-bss-store
;
; BYTE ? in .data? (uninitialized). Store 7 into it, load into rcx, exit.
; Expected exit: 7
;
.data?
slot BYTE ?

.code
ex_03_bss_store PROC
    sub rsp, 40
    mov BYTE PTR [slot], 7
    movzx rcx, BYTE PTR [slot]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_bss_store ENDP
main PROC
    sub     rsp, 40
    call    ex_03_bss_store
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
