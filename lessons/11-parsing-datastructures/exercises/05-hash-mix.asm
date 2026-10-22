; Exercise: 05-hash-mix
;
; Exercise 05: hash mix
; x=5; x^=x<<3; exit low byte.
;
; Contract: implement `ex_05_hash_mix` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 45
;

; 05-hash-mix
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_05_hash_mix:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_hash_mix in this file.
    call    ex_05_hash_mix
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
