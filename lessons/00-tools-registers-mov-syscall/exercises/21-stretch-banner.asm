; Exercise 21: stretch banner
;
; STRETCH: Print a 3-line ASCII banner, exit 0.
;
; Build: ml64 /c 21-stretch-banner.asm && link /OUT:21-stretch-banner.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-stretch-banner.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_21_stretch_banner:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_stretch_banner in this file.
    call    ex_21_stretch_banner
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
