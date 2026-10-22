; Exercise: 22-stretch-itoa
;
; Exercise 22: stretch itoa
; STRETCH: itoa 123 into buffer; return length 3.
; Expected stdout: (none)
;
; Contract: implement `ex_22_stretch_itoa` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; Exercise 22: 22-stretch-itoa (Win32 port)
; STRETCH: itoa 123 into buffer; write then exit 0. Also set len cell=3 and exit 3 instead if no write needed.
; Build: ml64 /c /Fo22-stretch-itoa.obj 22-stretch-itoa.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:22-stretch-itoa.exe 22-stretch-itoa.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_itoa:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_22_stretch_itoa in this file.
    call    ex_22_stretch_itoa
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
