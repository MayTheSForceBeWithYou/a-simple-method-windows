; Exercise: 01-soa-pos
;
; Exercise 01: soa pos
; xs[1]=5 ys[1]=6; exit xs+ys 11.
; Expected stdout: (none)
;
; Contract: implement `ex_01_soa_pos` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 11
;

; 01-soa-pos: soa pos
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_soa_pos:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_soa_pos in this file.
    call    ex_01_soa_pos
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
