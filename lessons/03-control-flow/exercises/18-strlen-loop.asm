; Exercise 18: strlen loop
;
; Cstring 'hello',0. Count length 5 into rcx.
;
; Build: ml64 /c 18-strlen-loop.asm && link /OUT:18-strlen-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-strlen-loop.obj kernel32.lib
;
; Expected exit: 5


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_strlen_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_strlen_loop in this file.
    call    ex_18_strlen_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
