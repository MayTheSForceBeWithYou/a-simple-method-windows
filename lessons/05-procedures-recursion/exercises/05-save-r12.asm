; Exercise: 05-save-r12
;
; Exercise 05: save r12
; Use r12 in callee; must push/pop. r12=42 preserved. Exit 42.
;
; Contract: implement `ex_05_save_r12` (MS x64). Return exit code in EAX.
; Expected exit: 42
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_save_r12:PROC

; TODO: write ex_05_save_r12 in this file.

main PROC
    sub     rsp, 40
    call    ex_05_save_r12
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
