; Exercise: 05-save-magic
;
; Magic 'PK01' first byte 'P'=80; exit 80.
; Expected stdout: (none)
; Expected exit: 80
;
.data
magic BYTE "PK01"

.code
ex_05_save_magic PROC
    sub rsp, 40
    movzx rcx, BYTE PTR [magic]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_save_magic ENDP
main PROC
    sub     rsp, 40
    call    ex_05_save_magic
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
