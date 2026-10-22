; 07-simd-lane-sum-stub.asm: Stub: lane sum (no SIMD), exit sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_simd_lane_sum_stub:PROC
main PROC
    ; TODO: write ex_07_simd_lane_sum_stub in this file.
    call    ex_07_simd_lane_sum_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
