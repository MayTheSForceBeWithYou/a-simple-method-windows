; Exercise: 20-write-from-bss
;
; Fill 4-byte bss with 'Z',CR,LF,'Z',LF. Write 5 bytes. Exit 0.
;
; Contract: implement `ex_20_write_from_bss` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_20_write_from_bss:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_write_from_bss in this file.
    call    ex_20_write_from_bss
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
