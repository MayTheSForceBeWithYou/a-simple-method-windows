; Exercise 27: print digits loop
;
; Print "01234\n" using a loop that stores digits into a buffer then one write. Exit 0.
;
; Build: ml64 /c 27-print-digits-loop.asm && link /OUT:27-print-digits-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 27-print-digits-loop.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_27_print_digits_loop:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_print_digits_loop in this file.
    call    ex_27_print_digits_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
