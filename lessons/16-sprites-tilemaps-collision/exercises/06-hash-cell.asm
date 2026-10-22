; Exercise: 06-hash-cell
;
; Exercise 06: hash cell
; cell=(x>>3)+((y>>3)<<4); x=10 y=10; compute exit &255.
; Expected stdout: (none)
;
; Contract: implement `ex_06_hash_cell` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 17
;

; 06-hash-cell: hash cell
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_hash_cell:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_06_hash_cell in this file.
    call    ex_06_hash_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
