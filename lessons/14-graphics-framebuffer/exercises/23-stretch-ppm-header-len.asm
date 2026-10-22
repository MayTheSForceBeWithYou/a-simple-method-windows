; Exercise: 23-stretch-ppm-header-len
;
; STRETCH: "P6\n" length 3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_ppm_header_len` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_ppm_header_len:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_ppm_header_len in this file.
    call    ex_23_stretch_ppm_header_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
