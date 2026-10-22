; Exercise: 14-mutual-parity-count
;
; Exercise 14: mutual parity count
; is_even(6)=1. MS x64 ABI.
;
; Contract: implement `ex_14_mutual_parity_count` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; Exercise 14: 14-mutual-parity-count.asm (Win32 port)
; Count down from 7 using mutual even/odd that returns steps; or: is_even chain returns 1 for 6. Exit 1.
; Build: ml64 /c /Fo14-mutual-parity-count.asm.obj 14-mutual-parity-count.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-mutual-parity-count.asm.exe 14-mutual-parity-count.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_mutual_parity_count:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_14_mutual_parity_count in this file.
    call    ex_14_mutual_parity_count
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
