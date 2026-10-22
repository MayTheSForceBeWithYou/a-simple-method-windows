; Exercise: 23-leaf-no-frame
;
; Leaf mul3(rcx)=rcx*3 without prologue. Exit 42 for input 14.
; Expected stdout: (none)
; Expected exit: 42
;
.code
ex_23_leaf_no_frame PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 14
    call mul3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_23_leaf_no_frame ENDP
main PROC
    sub     rsp, 40
    call    ex_23_leaf_no_frame
    mov     rcx, rax
    call    ExitProcess
main ENDP

mul3 PROC
    mov rax, rcx
    imul rax, 3
    ret
mul3 ENDP
END
