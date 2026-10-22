; Exercise: 08-from-scratch-macro-add
;
; FROM SCRATCH: MACRO ADD_IMM reg,imm; use to build 40+2 exit 42.
;
; Contract: implement `ex_08_from_scratch_macro_add` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_macro_add:PROC

; TODO: Define ADD_IMM MACRO reg, imm; add reg, imm; ENDM

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_macro_add in this file.
    call    ex_08_from_scratch_macro_add
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
