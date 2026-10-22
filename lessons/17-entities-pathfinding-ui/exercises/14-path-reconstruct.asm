; Exercise: 14-path-reconstruct
;
; Path length 4; exit 4.
; Expected stdout: (none)
;
; Contract: implement `ex_14_path_reconstruct` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_path_reconstruct:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_path_reconstruct in this file.
    call    ex_14_path_reconstruct
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
