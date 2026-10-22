; Exercise: 06-aos-sum
;
; AoS records {x,y}. Two ents (1,2), (3,4). Sum all=10.
;
; Contract: implement `ex_06_aos_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_aos_sum:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_06_aos_sum in this file.
    call    ex_06_aos_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
