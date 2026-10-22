; Exercise: 23-stretch-raw-mode-flag
;
; Exercise 23: stretch raw mode flag
; STRETCH: raw_mode byte set/clear; exit 0 after restore.
;
; Contract: implement `ex_23_stretch_raw_mode_flag` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 23-stretch-raw-mode-flag.asm: Track console mode (raw=1), exit raw
.DATA?
raw_mode QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_raw_mode_flag:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_raw_mode_flag in this file.
    call    ex_23_stretch_raw_mode_flag
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
