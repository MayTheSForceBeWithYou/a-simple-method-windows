; Exercise: 10-insert-middle
;
; Exercise 10: insert middle
; buf "AC" len2 cur1; insert B -> "ABC"; exit middle byte 66.
;
; Contract: implement `ex_10_insert_middle` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 66
;

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
    ; TODO: write ex_10_insert_middle in this file.
    call    ex_10_insert_middle
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
