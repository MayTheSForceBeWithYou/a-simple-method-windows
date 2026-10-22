; Exercise: 17-simd-horizontal-stub
;
; Exercise 17: simd horizontal stub
; Sum 4 lanes {1,2,3,4}=10 without SSE.
;
; Contract: implement `ex_17_simd_horizontal_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; 17-simd-horizontal-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_simd_horizontal_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_simd_horizontal_stub in this file.
    call    ex_17_simd_horizontal_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
