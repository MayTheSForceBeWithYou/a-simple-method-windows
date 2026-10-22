; Exercise: 13-fizz-count
;
; AoC-lite: count numbers 1..20 divisible by 3 (6). Exit 6.
;
; Contract: implement `ex_13_fizz_count` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_fizz_count:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_fizz_count in this file.
    call    ex_13_fizz_count
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
