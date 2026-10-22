; Exercise: 13-store-through-ptr
;
; lea rdx,[slot]; mov QWORD PTR [rdx], 77; mov rcx,[slot]; exit.
;
; Contract: implement `ex_13_store_through_ptr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 77
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_13_store_through_ptr:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_store_through_ptr in this file.
    call    ex_13_store_through_ptr
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
