; Exercise: 23-stretch-factorial5
;
; Exercise 23: stretch factorial5
; STRETCH: 5! = 120 using successive imul. Exit 120.
;
; Contract: implement `ex_23_stretch_factorial5` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 120
;

; Exercise 23: stretch factorial5
;
; STRETCH: 5! = 120 using successive imul. Exit 120.
;
; Build: ml64 /c 23-stretch-factorial5.asm && link /OUT:23-stretch-factorial5.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-factorial5.obj kernel32.lib
;
; Expected exit: 120


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_factorial5:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_factorial5 in this file.
    call    ex_23_stretch_factorial5
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
