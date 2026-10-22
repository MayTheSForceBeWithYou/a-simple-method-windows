; Exercise: 02-mutual-even-odd
;
; is_even/is_odd mutual recursion. is_even(4)->1; exit 1.
;
; Contract: implement `ex_02_mutual_even_odd` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
; Implement mutual `even`/`odd` helpers. In `ex_02_mutual_even_odd`, exit whether 4 is even (1).
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_02_mutual_even_odd:PROC

; TODO: write ex_02_mutual_even_odd in this file.

main PROC
    sub     rsp, 40
    call    ex_02_mutual_even_odd
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
