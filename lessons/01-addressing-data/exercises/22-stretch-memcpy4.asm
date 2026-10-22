; Exercise: 22-stretch-memcpy4
;
; Exercise 22: stretch memcpy4
; STRETCH: src BYTE 1,2,3,4. dst BYTE 4 DUP(?). Copy 4 bytes via register loads/stores. Sum dst into rcx (10).
;
; Contract: implement `ex_22_stretch_memcpy4` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; Exercise 22: stretch memcpy4
;
; STRETCH: src BYTE 1,2,3,4. dst BYTE 4 DUP(?). Copy 4 bytes via register loads/stores. Sum dst into rcx (10).
;
; Build: ml64 /c 22-stretch-memcpy4.asm && link /OUT:22-stretch-memcpy4.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-memcpy4.obj kernel32.lib
;
; Expected exit: 10


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_memcpy4:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_memcpy4 in this file.
    call    ex_22_stretch_memcpy4
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
