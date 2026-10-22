; Exercise: 17-three-lines
;
; Print "one\n" "two\n" "three\n". Exit 0.
;
; Contract: implement `ex_17_three_lines` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_17_three_lines:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_three_lines in this file.
    call    ex_17_three_lines
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
