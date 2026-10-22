; 04-delete-backspace.asm: Backspace at end (dec len), exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_delete_backspace:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_delete_backspace in this file.
    call    ex_04_delete_backspace
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
