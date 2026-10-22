; Exercise: 23-stretch-bit-reverse8
;
; Reverse bits of 080h -> 001h; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_bit_reverse8` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_bit_reverse8:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_bit_reverse8 in this file.
    call    ex_23_stretch_bit_reverse8
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
