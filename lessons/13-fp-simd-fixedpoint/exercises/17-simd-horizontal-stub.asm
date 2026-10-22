; 17-simd-horizontal-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_simd_horizontal_stub:PROC
main PROC
    ; TODO: implement ex_17_simd_horizontal_stub (student routine; defined in solutions/).
    call    ex_17_simd_horizontal_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
