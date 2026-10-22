; Exercise 16: 16-soa-sum (Win32 port)
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
; Build: ml64 /c /Fo16-soa-sum.obj 16-soa-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-soa-sum.exe 16-soa-sum.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_soa_sum:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: write ex_16_soa_sum in this file.
    call    ex_16_soa_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
