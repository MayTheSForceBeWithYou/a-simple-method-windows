; Exercise: 07-row-fill
;
; Fill 3 pixels with 9; exit mid.
; Expected stdout: (none)
; Expected exit: 9
;
.data?
row BYTE 3 DUP(?)

.code
ex_07_row_fill PROC
    sub rsp, 40
    mov BYTE PTR [row], 9
    mov BYTE PTR [row+1], 9
    mov BYTE PTR [row+2], 9
    movzx rcx, BYTE PTR [row+1]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_07_row_fill ENDP
main PROC
    sub     rsp, 40
    call    ex_07_row_fill
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
