; Exercise: 02-mutual-even-odd
;
; is_even/is_odd mutual recursion. is_even(4)->1; exit 1.
;
; Contract: implement `ex_02_mutual_even_odd` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_mutual_even_odd:PROC

; TODO: write ex_02_mutual_even_odd in this file.

main PROC
    sub     rsp, 40
    call    ex_02_mutual_even_odd
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
