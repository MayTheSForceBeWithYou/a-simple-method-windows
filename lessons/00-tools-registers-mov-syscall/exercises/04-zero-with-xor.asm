; Exercise: 04-zero-with-xor
;
; Zero RCX using xor, then exit 0. No mov immediate.
;
; Contract: implement `ex_04_zero_with_xor` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_04_zero_with_xor:PROC

main PROC
    sub     rsp, 40
    ; TODO: Use XOR to zero RCX (not mov rcx, 0), then call ExitProcess
    ; TODO: write ex_04_zero_with_xor in this file.
    call    ex_04_zero_with_xor
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
