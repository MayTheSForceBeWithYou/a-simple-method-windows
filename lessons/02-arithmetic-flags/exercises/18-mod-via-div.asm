; Exercise 18: mod via div
;
; Compute 42 % 5 using div; exit remainder 2.
;
; Build: ml64 /c 18-mod-via-div.asm && link /OUT:18-mod-via-div.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-mod-via-div.obj kernel32.lib
;
; Expected exit: 2


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_mod_via_div:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_mod_via_div in this file.
    call    ex_18_mod_via_div
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
