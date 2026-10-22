; Exercise: 15-bitfield-pack
;
; Implement `ex_15_bitfield_pack` in this file.
;
; Contract: implement `ex_15_bitfield_pack` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 85
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_15_bitfield_pack:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_bitfield_pack in this file.
    call    ex_15_bitfield_pack
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
