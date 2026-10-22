; Exercise: 11-read-nul
;
; Allocate zero-filled memory with VirtualAlloc; read 8 bytes; sum should be 0; exit 0.
;
; Contract: implement `ex_11_read_nul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_read_nul:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_read_nul in this file.
    call    ex_11_read_nul
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
