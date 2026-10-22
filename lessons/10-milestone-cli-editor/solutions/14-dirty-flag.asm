; Exercise: 14-dirty-flag
;
; Edit sets dirty=1; save clears; exit dirty 0.
; Expected exit: 0
;
.data?
dirty BYTE ?

.code
ex_14_dirty_flag PROC
    sub rsp, 40
    
    ; Edit sets dirty
    mov BYTE PTR [dirty], 1
    
    ; Save clears dirty
    mov BYTE PTR [dirty], 0
    
    movzx rcx, BYTE PTR [dirty]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_dirty_flag ENDP
main PROC
    sub     rsp, 40
    call    ex_14_dirty_flag
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
