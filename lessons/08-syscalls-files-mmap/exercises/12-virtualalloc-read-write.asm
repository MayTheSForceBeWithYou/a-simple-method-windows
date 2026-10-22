; Exercise: 12-virtualalloc-read-write
;
; VirtualAlloc 4096; write 99 at +100; read back; exit 99.
;
; Contract: implement `ex_12_virtualalloc_read_write` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 99
;
.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_virtualalloc_read_write:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_virtualalloc_read_write in this file.
    call    ex_12_virtualalloc_read_write
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
