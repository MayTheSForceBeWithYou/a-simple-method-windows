; Listing 08: SSE2 horizontal sum of four 32-bit lanes
; Expected exit: 10
; Expected stdout: (none)

.DATA
ALIGN 16
v DWORD 1, 2, 3, 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    movdqu  xmm0, XMMWORD PTR v
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 0E5h
    paddd   xmm0, xmm1
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 1
    paddd   xmm0, xmm1
    movd    ecx, xmm0
    call    ExitProcess
main ENDP
END
