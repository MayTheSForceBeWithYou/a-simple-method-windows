; Exercise 09: spawn entity
;
; Bump entity id; first spawn id=1; exit 1.
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
next_id QWORD 0

.code
main PROC
    sub rsp, 40
    inc QWORD PTR [next_id]
    mov rcx, QWORD PTR [next_id]
    call ExitProcess
main ENDP
END
