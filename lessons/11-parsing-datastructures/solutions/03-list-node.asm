; Exercise 03: list node
;
; Node {dq val, next}; one node val 9; exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.data?
node QWORD 2 DUP(?)

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [node], 9
    mov QWORD PTR [node+8], 0
    mov rcx, QWORD PTR [node]
    call ExitProcess
main ENDP
END
