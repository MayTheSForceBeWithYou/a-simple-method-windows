; Exercise 26: stretch atoi
;
; STRETCH: parse "42" decimal ascii into rcx (42) with a loop.
;
; Build: ml64 /c 26-stretch-atoi.asm && link /OUT:26-stretch-atoi.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-stretch-atoi.obj kernel32.lib
;
; Expected exit: 42


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_stretch_atoi:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_stretch_atoi in this file.
    call    ex_26_stretch_atoi
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
