; Exercise 20: write from bss
;
; Fill 4-byte bss with 'Z',CR,LF,'Z',LF. Write 5 bytes. Exit 0.
;
; Build: ml64 /c 20-write-from-bss.asm && link /OUT:20-write-from-bss.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-write-from-bss.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_20_write_from_bss:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_write_from_bss in this file.
    call    ex_20_write_from_bss
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
