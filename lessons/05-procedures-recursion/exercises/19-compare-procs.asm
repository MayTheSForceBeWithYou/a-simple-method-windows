; Exercise: 19-compare-procs
;
; cmp_i64(3,5) returns 0 for less, 1 for eq, 2 for greater. Exit 0.
;
; Contract: implement `ex_19_compare_procs` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_19_compare_procs:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_19_compare_procs in this file.
    call    ex_19_compare_procs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
