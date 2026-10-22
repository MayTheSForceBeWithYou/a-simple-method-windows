; Exercise: 14-frame-stats
;
; fps counter frames=60 over 1s; exit 60.
; Expected stdout: (none)
; Expected exit: 60
;
.data?
frames QWORD ?

.code
ex_14_frame_stats PROC
    sub rsp, 40
    mov QWORD PTR [frames], 60
    mov rcx, [frames]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_frame_stats ENDP
main PROC
    sub     rsp, 40
    call    ex_14_frame_stats
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
