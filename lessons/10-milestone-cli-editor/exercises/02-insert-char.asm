; 02-insert-char.asm: Append 'A', exit with length (1)
.DATA?
buf DB 256 DUP(?)
len QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_insert_char:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_02_insert_char (student routine; defined in solutions/).
    call    ex_02_insert_char
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
