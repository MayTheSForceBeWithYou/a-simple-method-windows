; Exercise 13: hashmap put get
;
; Simple open array slots[4]; put key hash 2 -> 42; get exit 42.
; Expected exit: 42

EXTERN ExitProcess:PROC

.data?
slots QWORD 4 DUP(?)

.code
ex_13_hashmap_put_get PROC
    sub rsp, 40
    mov QWORD PTR [slots+16], 42
        mov     eax, ecx
    add     rsp, 40
    ret
ex_13_hashmap_put_get ENDP
main PROC
    sub     rsp, 40
    call    ex_13_hashmap_put_get
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
