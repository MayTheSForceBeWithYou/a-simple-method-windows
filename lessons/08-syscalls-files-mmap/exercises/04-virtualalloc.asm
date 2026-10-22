; Exercise: 04-virtualalloc
;
; VirtualAlloc 4096 bytes RW; store 42; exit 42.
;
; Contract: implement `ex_04_virtualalloc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_04_virtualalloc:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_virtualalloc in this file.
    call    ex_04_virtualalloc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
