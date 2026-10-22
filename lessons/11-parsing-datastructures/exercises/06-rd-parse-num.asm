; Exercise: 06-rd-parse-num
;
; Parse '3' into value; exit 3.
;
; Contract: implement `ex_06_rd_parse_num` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_06_rd_parse_num:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_rd_parse_num in this file.
    call    ex_06_rd_parse_num
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
