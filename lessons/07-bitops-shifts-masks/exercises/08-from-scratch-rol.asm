; Exercise: 08-from-scratch-rol
;
; Implement `ex_08_from_scratch_rol` in this file.
;
; Contract: implement `ex_08_from_scratch_rol` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_rol:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_rol in this file.
    call    ex_08_from_scratch_rol
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
