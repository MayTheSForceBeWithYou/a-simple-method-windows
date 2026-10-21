; Listing 08: SSE2 horizontal sum of four 32-bit lanes
; Expected exit: 10
; Expected stdout: (none)
;
; Lane trace (lane0 .. lane3), v = [1, 2, 3, 4]:
;   movdqu xmm0 -> [1, 2, 3, 4]
;   pshufd xmm1, xmm0, 4Eh -> [3, 4, 1, 2]
;   paddd xmm0, xmm1       -> [4, 6, 4, 6]
;   pshufd xmm1, xmm0, 0B1h -> [6, 4, 6, 4]
;   paddd xmm0, xmm1       -> [10, 10, 10, 10]; movd ecx, xmm0 -> 10

.DATA
ALIGN 16
v DWORD 1, 2, 3, 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    movdqu  xmm0, XMMWORD PTR v
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 4Eh
    paddd   xmm0, xmm1
    movdqa  xmm1, xmm0
    pshufd  xmm1, xmm1, 0B1h
    paddd   xmm0, xmm1
    movd    ecx, xmm0
    call    ExitProcess
main ENDP
END
