; Exercise 23: stretch ui modal
;
; STRETCH: modal stack depth 1; exit 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
modal_depth QWORD 0

.code

ex_23_stretch_ui_modal PROC
inc QWORD PTR [modal_depth]
    mov rcx, QWORD PTR [modal_depth]
    mov     eax, QWORD PTR [modal_depth]
    ret
ex_23_stretch_ui_modal ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_ui_modal
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
