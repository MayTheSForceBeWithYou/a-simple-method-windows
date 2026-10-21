; Listing 09: Frame-ready flag cleared (vsync pacing stub)
; Expected exit: 0
; Expected stdout: (none)

.DATA?
frame_ready BYTE ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     BYTE PTR frame_ready, 0
    movzx   ecx, BYTE PTR frame_ready
    call    ExitProcess
main ENDP
END
