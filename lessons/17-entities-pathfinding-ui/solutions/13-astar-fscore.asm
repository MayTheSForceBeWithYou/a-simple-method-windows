; Exercise 13: astar fscore
;
; f=g+h; g=3 h=4; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 3
    add rcx, 4
    call ExitProcess
main ENDP
END
