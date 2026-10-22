; Exercise 15: rip relative
;
; Use lea rdx,[msg] (RIP-relative by default in MASM x64) to write msg 'rip\n'. Exit 0.
;
; Build: ml64 /c 15-rip-relative.asm && link /OUT:15-rip-relative.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-rip-relative.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_rip_relative:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_rip_relative in this file.
    call    ex_15_rip_relative
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
