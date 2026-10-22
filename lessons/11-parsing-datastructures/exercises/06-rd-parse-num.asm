; 06-rd-parse-num
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_rd_parse_num:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_rd_parse_num in this file.
    call    ex_06_rd_parse_num
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
