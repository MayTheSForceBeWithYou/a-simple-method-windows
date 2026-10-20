; Listing 01: SSE packed addition
;
; Purpose: Demonstrate SIMD with XMM registers.
; Expected exit code: 0 (success)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-sse-add.obj 01-sse-add.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-sse-add.exe 01-sse-add.obj kernel32.lib

.DATA
ALIGN 16
vec1 REAL4 1.0, 2.0, 3.0, 4.0
vec2 REAL4 5.0, 6.0, 7.0, 8.0
result REAL4 4 DUP(0.0)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; Load vectors into XMM registers
    movaps xmm0, XMMWORD PTR vec1
    movaps xmm1, XMMWORD PTR vec2
    
    ; Packed addition: result = vec1 + vec2
    addps xmm0, xmm1
    
    ; Store result
    movaps XMMWORD PTR result, xmm0
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
