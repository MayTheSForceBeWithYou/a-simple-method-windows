; Exercise: 10-len-equ
;
; Define string "equ works\n" with BYTE; length via EQU $ - label. Write it; exit 0.
;
; Contract: implement `ex_10_len_equ` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
; TODO: Declare 'msg' with "Test message" and CRLF
; TODO: Use 'msg_len EQU $ - msg' to compute length

.DATA?
bytes_written DQ ?

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_10_len_equ:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_len_equ in this file.
    call    ex_10_len_equ
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
