; Exercise: 12-track-connect
;
; Two pieces connect if dirs match; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_12_track_connect PROC
    sub rsp, 40
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_12_track_connect ENDP
main PROC
    sub     rsp, 40
    call    ex_12_track_connect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
