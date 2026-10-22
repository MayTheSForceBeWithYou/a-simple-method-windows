; Exercise: 11-delete-forward
;
; "ABCD" cur=1 delete -> "ACD"; len=3 exit 3.
;
; Contract: implement `ex_11_delete_forward` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_delete_forward:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_delete_forward in this file.
    call    ex_11_delete_forward
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
