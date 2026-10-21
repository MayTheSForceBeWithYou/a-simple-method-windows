; Exercise 09: xor checksum
; XOR-fold bytes 1,2,4,8 -> 15.
; Expected exit: 15

EXTERN ExitProcess:PROC

.data
b BYTE 1,2,4,8

.code
main PROC
    sub rsp, 40
    xor eax, eax
    xor al, b[0]
    xor al, b[1]
    xor al, b[2]
    xor al, b[3]
    movzx rcx, al
    call ExitProcess
main ENDP
END
