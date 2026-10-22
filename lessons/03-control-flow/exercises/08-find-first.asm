; Exercise 08: find first
;
; arr BYTE 3,1,4,1,5. Find first index of 4 (2). Exit index.
;
; Build: ml64 /c 08-find-first.asm && link /OUT:08-find-first.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-find-first.obj kernel32.lib
;
; Expected exit: 2


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_find_first:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_find_first in this file.
    call    ex_08_find_first
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
