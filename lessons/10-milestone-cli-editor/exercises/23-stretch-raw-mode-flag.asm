; 23-stretch-raw-mode-flag.asm: Track console mode (raw=1), exit raw
.DATA?
raw_mode QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_raw_mode_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_23_stretch_raw_mode_flag (student routine; defined in solutions/).
    call    ex_23_stretch_raw_mode_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
