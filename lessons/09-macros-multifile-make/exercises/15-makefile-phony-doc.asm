; Exercise: 15-makefile-phony-doc
;
; Exercise 15: makefile phony doc
; Documents build script; program exits 0. Read comment about build targets.
;
; Contract: implement `ex_15_makefile_phony_doc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 15-makefile-phony-doc.asm
; Comment about .PHONY targets, exit 0.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_makefile_phony_doc:PROC

; .PHONY in Makefile marks non-file targets like "clean" or "all"

main PROC
    sub     rsp, 40
    ; TODO: return 0 from ex_15_makefile_phony_doc (.PHONY comment in header).
    call    ex_15_makefile_phony_doc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
