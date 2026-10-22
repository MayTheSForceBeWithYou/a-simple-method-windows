; Exercise 17: simd horizontal stub
;
; Sum 4 lanes {1,2,3,4}=10 without SSE.
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
v DWORD 1,2,3,4

.code
ex_17_simd_horizontal_stub PROC
    sub rsp, 40
    mov eax, DWORD PTR [v]
    add eax, DWORD PTR [v+4]
    add eax, DWORD PTR [v+8]
    add eax, DWORD PTR [v+12]
    mov ecx, eax
    mov     eax, eax
    add     rsp, 40
    ret
ex_17_simd_horizontal_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_17_simd_horizontal_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
