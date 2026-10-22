; Exercise: 20-max-via-flags
;
; Exercise 20: max via flags
; a=17,b=23 in regs. cmp; use cmovg to put max in rcx. Exit 23.
;
; Contract: implement `ex_20_max_via_flags` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 23
;

; Exercise 20: max via flags
;
; a=17,b=23 in regs. cmp; use cmovg to put max in rcx. Exit 23.
;
; Build: ml64 /c 20-max-via-flags.asm && link /OUT:20-max-via-flags.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-max-via-flags.obj kernel32.lib
;
; Expected exit: 23


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_20_max_via_flags:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_max_via_flags in this file.
    call    ex_20_max_via_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
