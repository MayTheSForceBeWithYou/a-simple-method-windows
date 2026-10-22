; Exercise 07: simd lane sum stub
;
; Sum 4 bytes as if SIMD lanes; exit 10.
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
v BYTE 1,2,3,4

.code
ex_07_simd_lane_sum_stub PROC
    sub rsp, 40
    xor rcx, rcx
    movzx rax, BYTE PTR [v]
    add rcx, rax
    movzx rax, BYTE PTR [v+1]
    add rcx, rax
    movzx rax, BYTE PTR [v+2]
    add rcx, rax
    movzx rax, BYTE PTR [v+3]
    add rcx, rax
    mov     eax, 10
    ret
    add     rsp, 40
ex_07_simd_lane_sum_stub ENDP
main PROC
    call    ex_07_simd_lane_sum_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
