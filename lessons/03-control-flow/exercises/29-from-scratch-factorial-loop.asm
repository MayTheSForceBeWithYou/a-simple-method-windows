; Exercise 29: from scratch factorial loop
;
; FROM SCRATCH: 6! with a counted loop = 720. Exit 720&255=208.
;
; Build: ml64 /c 29-from-scratch-factorial-loop.asm && link /OUT:29-from-scratch-factorial-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 29-from-scratch-factorial-loop.obj kernel32.lib
;
; Expected exit: 208


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_29_from_scratch_factorial_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_29_from_scratch_factorial_loop in this file.
    call    ex_29_from_scratch_factorial_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
