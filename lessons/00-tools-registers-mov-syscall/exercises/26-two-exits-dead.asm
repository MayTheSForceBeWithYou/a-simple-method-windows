; Exercise 26: two exits dead
;
; Write "alive\n", exit 0, then dead exit 99 after (unreachable).
;
; Build: ml64 /c 26-two-exits-dead.asm && link /OUT:26-two-exits-dead.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-two-exits-dead.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_two_exits_dead:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_two_exits_dead in this file.
    call    ex_26_two_exits_dead
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
