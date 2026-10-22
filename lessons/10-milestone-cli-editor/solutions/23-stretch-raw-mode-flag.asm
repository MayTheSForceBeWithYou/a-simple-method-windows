; Exercise: 23-stretch-raw-mode-flag
;
; STRETCH: raw_mode byte set/clear; exit 0 after restore.
; Expected exit: 0
;
.data?
raw BYTE ?

.code
ex_23_stretch_raw_mode_flag PROC
    sub rsp, 40
    
    mov BYTE PTR [raw], 1
    mov BYTE PTR [raw], 0
    
    movzx rcx, BYTE PTR [raw]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_stretch_raw_mode_flag ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_raw_mode_flag
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
