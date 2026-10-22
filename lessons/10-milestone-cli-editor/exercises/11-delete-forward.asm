; 11-delete-forward.asm: Delete at cursor=1 in "ABC", exit len (2)
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_delete_forward:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_11_delete_forward (student routine; defined in solutions/).
    call    ex_11_delete_forward
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
