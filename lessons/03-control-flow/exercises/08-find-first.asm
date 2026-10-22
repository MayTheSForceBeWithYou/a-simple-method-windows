; Exercise: 08-find-first
;
; arr BYTE 3,1,4,1,5. Find first index of 4 (2). Exit index.
;
; Contract: implement `ex_08_find_first` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_08_find_first:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_find_first in this file.
    call    ex_08_find_first
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
