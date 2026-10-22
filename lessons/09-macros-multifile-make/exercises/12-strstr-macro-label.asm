; Exercise: 12-strstr-macro-label
;
; MACRO TWICE with inc instructions; exit 2.
;
; Contract: implement `ex_12_strstr_macro_label` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_strstr_macro_label:PROC

; TODO: TWICE MACRO; inc rax; inc rax; ENDM (no labels needed)

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_strstr_macro_label in this file.
    call    ex_12_strstr_macro_label
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
