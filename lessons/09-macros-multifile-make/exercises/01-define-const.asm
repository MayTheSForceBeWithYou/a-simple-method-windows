; Exercise: 01-define-const
;
; Exercise 01: define const
; Define constant EXIT; exit 0.
;
; Contract: implement `ex_01_define_const` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 01-define-const.asm
; Define a constant, use it, exit 0.
; Task: Define STATUS_OK = 0 using EQU, move it to ECX, call ExitProcess.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_define_const:PROC

; TODO: Define STATUS_OK EQU 0

main PROC
    sub     rsp, 40
    ; TODO: mov ecx, STATUS_OK; call ExitProcess
    ; TODO: write ex_01_define_const in this file.
    call    ex_01_define_const
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
