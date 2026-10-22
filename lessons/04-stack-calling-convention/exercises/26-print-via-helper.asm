; Exercise: 26-print-via-helper
;
; Helper write_str(rcx=buf, rdx=len). Print "abi\n"; exit 0.
; Expected stdout: "abi\n"
;
; Contract: implement `ex_26_print_via_helper` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
; Implement `print_msg` using WriteFile on stdout. In `ex_26_print_via_helper`, print `walkMsg` and exit 0.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_26_print_via_helper:PROC

; TODO: write ex_26_print_via_helper in this file.

main PROC
    sub     rsp, 40
    call    ex_26_print_via_helper
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
