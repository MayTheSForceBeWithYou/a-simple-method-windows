; Exercise: 14-two-arrays-sum
;
; a QWORD 3,4  b QWORD 5,6. rcx = a[0]+a[1]+b[0]+b[1] (18), exit.
;
; Contract: implement `ex_14_two_arrays_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 18
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_14_two_arrays_sum:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_two_arrays_sum in this file.
    call    ex_14_two_arrays_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
