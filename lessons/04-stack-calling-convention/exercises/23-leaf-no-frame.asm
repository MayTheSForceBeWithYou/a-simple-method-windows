; Exercise: 23-leaf-no-frame
;
; Leaf mul3(rcx)=rcx*3 without prologue. Exit 42 for input 14.
; Expected stdout: (none)
;
; Contract: implement `ex_23_leaf_no_frame` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_23_leaf_no_frame:PROC

; TODO: write ex_23_leaf_no_frame in this file.

main PROC
    sub     rsp, 40
    call    ex_23_leaf_no_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
