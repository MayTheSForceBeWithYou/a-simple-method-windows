; Exercise: 06-displacement
;
; struct-like: base label vals with QWORD 1,2,3. Load third qword via [vals+16] into rcx, exit.
;
; Contract: implement `ex_06_displacement` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA
arr DQ 5, 15, 25

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_06_displacement:PROC

main PROC
    sub     rsp, 40
    ; TODO: LEA RBX, arr
    ; TODO: MOV RAX, [RBX+8] to get second element
    ; TODO: Exit with RAX
    ; TODO: write ex_06_displacement in this file.
    call    ex_06_displacement
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
