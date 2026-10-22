; Exercise: 02-rodata-string
;
; Put "rodata\n" in .const (read-only data), write it, exit 0.
;
; Contract: implement `ex_02_rodata_string` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_02_rodata_string:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_rodata_string in this file.
    call    ex_02_rodata_string
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
