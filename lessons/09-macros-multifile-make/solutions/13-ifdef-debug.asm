; Exercise: 13-ifdef-debug
;
; Define DEBUG; IFDEF DEBUG mov rcx,1 ELSE 0; exit 1.
; Expected exit: 1
;
.code
ex_13_ifdef_debug PROC
    sub rsp, 40
    
    ; MASM conditional assembly
    IFDEF DEBUG
        mov rcx, 1
    ELSE
        mov rcx, 0
    ENDIF
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_ifdef_debug ENDP
main PROC
    sub     rsp, 40
    call    ex_13_ifdef_debug
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
