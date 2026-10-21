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
main PROC
    sub rsp, 40
    inc QWORD PTR [modal_depth]
    mov rcx, QWORD PTR [modal_depth]
    call ExitProcess
main ENDP
END
