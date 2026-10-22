; Exercise: 16-soa-sum
;
; Exercise 16: soa sum
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
; Expected stdout: (none)
;
; Contract: implement `ex_16_soa_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 21
;

; Exercise 16: 16-soa-sum (Win32 port)
; SoA xs={1,2,3} ys={4,5,6}; sum all 21.
; Build: ml64 /c /Fo16-soa-sum.obj 16-soa-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-soa-sum.exe 16-soa-sum.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_soa_sum:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_16_soa_sum in this file.
    call    ex_16_soa_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
