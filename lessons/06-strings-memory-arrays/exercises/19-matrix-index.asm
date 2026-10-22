; Exercise: 19-matrix-index
;
; Row-major 3x3; get (r=1,c=2) from 1..9 matrix -> 6.
; Expected stdout: (none)
;
; Contract: implement `ex_19_matrix_index` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_matrix_index:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_19_matrix_index in this file.
    call    ex_19_matrix_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
