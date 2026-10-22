; 15-makefile-phony-doc.asm
; Comment about .PHONY targets, exit 0.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_makefile_phony_doc:PROC

; .PHONY in Makefile marks non-file targets like "clean" or "all"

main PROC
    ; TODO: xor ecx, ecx; mov ecx, 1
    ; TODO: implement ex_15_makefile_phony_doc (student routine; defined in solutions/).
    call    ex_15_makefile_phony_doc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
