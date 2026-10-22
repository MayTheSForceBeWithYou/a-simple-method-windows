; 06-rd-parse-num
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_rd_parse_num:PROC
main PROC
    ; TODO: implement ex_06_rd_parse_num (student routine; defined in solutions/).
    call    ex_06_rd_parse_num
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
