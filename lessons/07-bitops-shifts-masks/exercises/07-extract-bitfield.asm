; Exercise: 07-extract-bitfield
;
; Implement `ex_07_extract_bitfield` in this file.
;
; Contract: implement `ex_07_extract_bitfield` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_extract_bitfield:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_extract_bitfield in this file.
    call    ex_07_extract_bitfield
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
