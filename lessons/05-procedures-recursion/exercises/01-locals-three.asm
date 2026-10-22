; Exercise: 01-locals-three
;
; Exercise 01: locals three
; Function with 3 qword locals. sum_locals(10)=10+11+12=33.
;
; Contract: implement `ex_01_locals_three` (MS x64). Return exit code in EAX.
; Expected exit: 33
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_locals_three:PROC

; TODO: write ex_01_locals_three in this file.

main PROC
    sub     rsp, 40
    call    ex_01_locals_three
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
