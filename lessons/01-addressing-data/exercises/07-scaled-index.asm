; Exercise: 07-scaled-index
;
; arr QWORD 5,10,15,20. Set r8=2, load arr[r8] with [arr+r8*8] into rcx, exit (15).
;
; Contract: implement `ex_07_scaled_index` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.DATA
arr DQ 11, 22, 33, 44

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_07_scaled_index:PROC

main PROC
    sub     rsp, 40
    ; TODO: LEA base address into RBX
    ; TODO: MOV index 2 into RCX
    ; TODO: MOV RAX, [RBX+RCX*8]
    ; TODO: Exit with RAX
    ; TODO: write ex_07_scaled_index in this file.
    call    ex_07_scaled_index
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
