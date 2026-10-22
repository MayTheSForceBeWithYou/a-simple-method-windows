; Exercise: 05-dot2-fixed
;
; Exercise 05: dot2 fixed
; dot (1,2)*(3,4)=11; exit 11.
;
; Contract: implement `ex_05_dot2_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 11
;

; 05-dot2-fixed.asm: Dot product 2D vectors in Q16.16
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_dot2_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_dot2_fixed in this file.
    call    ex_05_dot2_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
