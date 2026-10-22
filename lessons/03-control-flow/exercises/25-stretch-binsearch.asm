; Exercise 25: stretch binsearch
;
; STRETCH: sorted QWORD 1,3,5,7,9. Binary search for 7; exit index 3.
;
; Build: ml64 /c 25-stretch-binsearch.asm && link /OUT:25-stretch-binsearch.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-stretch-binsearch.obj kernel32.lib
;
; Expected exit: 3


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_25_stretch_binsearch:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_stretch_binsearch in this file.
    call    ex_25_stretch_binsearch
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
