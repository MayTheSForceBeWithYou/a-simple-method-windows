; Exercise 02: je equal
;
; rax=3,rbx=3. If equal exit 1 else 0.
;
; Build: ml64 /c 02-je-equal.asm && link /OUT:02-je-equal.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-je-equal.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_je_equal:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_02_je_equal in this file.
    call    ex_02_je_equal
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
