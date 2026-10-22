; Exercise: 24-from-scratch-fb-size
;
; FROM SCRATCH: w=320 h=200 bpp=4 bytes; size &0FFh of low... 320*200*4=256000; exit (size>>12)&255 or simply exit 0 after computing into rax and using 256000/10000=25.6 - exit 25 via /10240. Simpler: exit (w*h*bpp)>>16 = 3.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_fb_size` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_24_from_scratch_fb_size:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_fb_size in this file.
    call    ex_24_from_scratch_fb_size
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
