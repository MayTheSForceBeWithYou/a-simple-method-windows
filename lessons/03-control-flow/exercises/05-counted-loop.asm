; Exercise 05: counted loop
;
; Add r8 times: start rcx=0,r8=5; loop add 3 each time; exit 15.
;
; Build: ml64 /c 05-counted-loop.asm && link /OUT:05-counted-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-counted-loop.obj kernel32.lib
;
; Expected exit: 15


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_counted_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_counted_loop in this file.
    call    ex_05_counted_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
