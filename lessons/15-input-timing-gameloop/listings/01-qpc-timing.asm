; QueryPerformanceCounter timing, exit 0
.DATA?
counter QWORD ?
freq QWORD ?
.CODE
EXTRN QueryPerformanceCounter:PROC
EXTRN QueryPerformanceFrequency:PROC
EXTRN ExitProcess:PROC
main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog
    lea rcx, freq
    call QueryPerformanceFrequency
    lea rcx, counter
    call QueryPerformanceCounter
    xor ecx, ecx
    call ExitProcess
main ENDP
END
