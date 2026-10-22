; 17-simd-horizontal-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_simd_horizontal_stub:PROC
main PROC
    ; TODO: write ex_17_simd_horizontal_stub in this file.
    call    ex_17_simd_horizontal_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
