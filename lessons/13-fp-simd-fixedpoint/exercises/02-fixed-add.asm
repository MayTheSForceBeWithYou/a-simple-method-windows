; Exercise: 02-fixed-add
;
; Exercise 02: fixed add
; 1.5 + 2.5 in Q16.16; exit 4.
;
; Contract: implement `ex_02_fixed_add` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; 02-fixed-add.asm: Add Q16.16: 1.5 + 2.5, exit 4
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_fixed_add:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_fixed_add in this file.
    call    ex_02_fixed_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
