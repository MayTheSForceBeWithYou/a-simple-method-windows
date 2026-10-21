; Exercise 16: soa sum
;
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
;
; Expected exit: 21
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
xs QWORD 1,2,3
ys QWORD 4,5,6

.code
main PROC
    sub rsp, 40
    mov rcx, QWORD PTR [xs]
    add rcx, QWORD PTR [xs+8]
    add rcx, QWORD PTR [xs+16]
    add rcx, QWORD PTR [ys]
    add rcx, QWORD PTR [ys+8]
    add rcx, QWORD PTR [ys+16]
    call ExitProcess
main ENDP
END
