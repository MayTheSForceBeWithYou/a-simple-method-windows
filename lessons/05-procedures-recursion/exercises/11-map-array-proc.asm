; Exercise: 11-map-array-proc
;
; apply_inc: for {1,2,3,4}, +=1 each. Sum=2+3+4+5=14.
;
; Contract: implement `ex_11_map_array_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 14
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_map_array_proc:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_11_map_array_proc in this file.
    call    ex_11_map_array_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
