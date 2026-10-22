; 10-insert-middle.asm: Insert 'B' at cursor=1 in "AC", exit 66 ('B')
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_insert_middle:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_10_insert_middle (student routine; defined in solutions/).
    call    ex_10_insert_middle
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
