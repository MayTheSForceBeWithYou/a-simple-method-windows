; Exercise: 06-set-file-pointer
;
; Without real file: simulate offset add; exit 10.
;
; Contract: implement `ex_06_set_file_pointer` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_set_file_pointer:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_set_file_pointer in this file.
    call    ex_06_set_file_pointer
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
