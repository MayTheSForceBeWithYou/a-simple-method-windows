; Exercise: 08-div-remainder
;
; Exercise 08: div remainder
; Unsigned: 20 / 6. Exit with remainder (rdx) = 2.
;
; Contract: implement `ex_08_div_remainder` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 08: div remainder (Win32 port)
;
; RAX=100, divisor=7. XOR RDX and DIV. Exit with remainder (2).
;
; Build: ml64 /c /Fo08-div-remainder.obj 08-div-remainder.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-div-remainder.exe 08-div-remainder.obj kernel32.lib
; Run: 08-div-remainder.exe & echo %ERRORLEVEL%
;
; Expected exit: 2
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_div_remainder:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_08_div_remainder in this file.
    call    ex_08_div_remainder
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
