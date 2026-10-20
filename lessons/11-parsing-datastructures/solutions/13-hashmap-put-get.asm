; Exercise 13: hashmap put get
;
; Simple open array slots[4]; put key hash 2 -> 42; get exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slots QWORD 4 DUP(?)

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [slots+16], 42
    mov rcx, QWORD PTR [slots+16]
    call ExitProcess
main ENDP
END
