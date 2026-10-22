; Exercise: 01-add-sub
;
; rcx=100; add 20; sub 78; exit (42).
;
; Contract: implement `ex_01_add_sub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_add_sub:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_01_add_sub in this file.
    call    ex_01_add_sub
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
