; Exercise: 02-dt-accum
;
; Exercise 02: dt accum
; accum+=dt; if >= step then tick++; exit ticks 2 for accum sim.
; Expected stdout: (none)
;
; Contract: implement `ex_02_dt_accum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 02-dt-accum: dt accum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_dt_accum:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_dt_accum in this file.
    call    ex_02_dt_accum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
