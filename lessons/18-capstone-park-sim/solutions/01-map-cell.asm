; Exercise: 01-map-cell
;
; Set cell type path=1; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
map BYTE 256 DUP(?)

.code
ex_01_map_cell PROC
    sub rsp, 40
    mov BYTE PTR [map+10], 1
    movzx rcx, BYTE PTR [map+10]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_map_cell ENDP
main PROC
    sub     rsp, 40
    call    ex_01_map_cell
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
