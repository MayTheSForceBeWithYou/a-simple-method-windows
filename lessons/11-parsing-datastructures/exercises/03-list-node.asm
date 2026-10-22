; Exercise: 03-list-node
;
; Node {dq val, next}; one node val 9; exit 9.
;
; Contract: implement `ex_03_list_node` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_list_node:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_list_node in this file.
    call    ex_03_list_node
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
