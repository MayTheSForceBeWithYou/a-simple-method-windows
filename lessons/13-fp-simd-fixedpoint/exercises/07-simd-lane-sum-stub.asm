; Exercise: 07-simd-lane-sum-stub
;
; Exercise 07: simd lane sum stub
; Sum 4 bytes as if SIMD lanes; exit 10.
;
; Contract: implement `ex_07_simd_lane_sum_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; 07-simd-lane-sum-stub.asm: Stub: lane sum (no SIMD), exit sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_simd_lane_sum_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_simd_lane_sum_stub in this file.
    call    ex_07_simd_lane_sum_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
