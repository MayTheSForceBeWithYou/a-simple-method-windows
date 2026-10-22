; Exercise: 24-from-scratch-compile-add
;
; FROM SCRATCH: compile-time eval of 40+2; exit 42.
;
; Contract: implement `ex_24_from_scratch_compile_add` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_compile_add:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_compile_add in this file.
    call    ex_24_from_scratch_compile_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
