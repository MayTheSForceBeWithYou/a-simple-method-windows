; Exercise: 20-type-check-int
;
; Exercise 20: type check int
; Type tag int=1; expression type int; exit 1.
;
; Contract: implement `ex_20_type_check_int` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 20-type-check-int.asm: Check expression type is INT, exit 1 if true
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_type_check_int:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_type_check_int in this file.
    call    ex_20_type_check_int
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
