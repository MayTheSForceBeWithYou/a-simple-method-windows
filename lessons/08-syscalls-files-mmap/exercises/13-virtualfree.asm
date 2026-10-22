; Exercise: 13-virtualfree
;
; VirtualAlloc then VirtualFree; exit 0 if VirtualFree succeeds.
;
; Contract: implement `ex_13_virtualfree` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTRN ex_13_virtualfree:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_virtualfree in this file.
    call    ex_13_virtualfree
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
