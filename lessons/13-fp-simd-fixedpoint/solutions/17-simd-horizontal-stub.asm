; Exercise 17: simd horizontal stub
;
; Sum 4 lanes {1,2,3,4}=10 without SSE.
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
v DWORD 1,2,3,4

.code
main PROC
    sub rsp, 32
    mov eax, DWORD PTR [v]
    add eax, DWORD PTR [v+4]
    add eax, DWORD PTR [v+8]
    add eax, DWORD PTR [v+12]
    mov ecx, eax
    call ExitProcess
main ENDP
END
