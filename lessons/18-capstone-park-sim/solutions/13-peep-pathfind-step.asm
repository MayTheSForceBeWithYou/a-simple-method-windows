; Exercise 13: peep pathfind step
;
; Peep follows path; steps remaining 4; exit 4.
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
steps QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [steps], 4
    mov rcx, QWORD PTR [steps]
    call ExitProcess
main ENDP
END
