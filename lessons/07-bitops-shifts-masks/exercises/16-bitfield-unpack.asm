; Exercise: 16-bitfield-unpack
;
; Implement `ex_16_bitfield_unpack` in this file.
;
; Contract: implement `ex_16_bitfield_unpack` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_16_bitfield_unpack:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_bitfield_unpack in this file.
    call    ex_16_bitfield_unpack
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
