; Exercise 17: three lines
;
; Print "one\n" "two\n" "three\n". Exit 0.
;
; Build: ml64 /c 17-three-lines.asm && link /OUT:17-three-lines.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-three-lines.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_three_lines:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_three_lines in this file.
    call    ex_17_three_lines
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
