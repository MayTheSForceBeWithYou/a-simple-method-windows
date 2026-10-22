; Exercise: 02-insert-char
;
; Insert 'A' at end; len=1; exit 1.
;
; Contract: implement `ex_02_insert_char` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_insert_char:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_insert_char in this file.
    call    ex_02_insert_char
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
