; Exercise: 26-print-via-helper
;
; Exercise 26: print via helper
; Helper write_str(rcx=buf, rdx=len). Print "abi\n"; exit 0.
;
; Contract: implement `ex_26_print_via_helper` (MS x64). Return exit code in EAX.
; Expected exit: 0
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_print_via_helper:PROC

; TODO: write ex_26_print_via_helper in this file.

main PROC
    sub     rsp, 40
    call    ex_26_print_via_helper
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
