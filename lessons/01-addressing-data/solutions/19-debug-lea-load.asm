; Exercise: 19-debug-lea-load
;
; BUG: used lea to 'load' value. Fix to mov from memory; x QWORD 55; exit 55.
; Expected exit: 55
;
.data
x QWORD 55

.code
ex_19_debug_lea_load PROC
    sub rsp, 40
    mov rcx, [x]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_19_debug_lea_load ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_lea_load
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
