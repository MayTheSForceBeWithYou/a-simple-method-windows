; Exercise: 23-stretch-utf8-ascii-validate
;
; Exercise 23: stretch ascii validate
; STRETCH: validate all bytes <128 in "OK\n"; exit 1 if valid.
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_utf8_ascii_validate` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; Exercise 23: 23-stretch-utf8-ascii-validate (Win32 port)
; STRETCH: validate all bytes <128 in "OK\n"; exit 1 if valid.
; Build: ml64 /c /Fo23-stretch-utf8-ascii-validate.obj 23-stretch-utf8-ascii-validate.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:23-stretch-utf8-ascii-validate.exe 23-stretch-utf8-ascii-validate.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_utf8_ascii_validate:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_23_stretch_utf8_ascii_validate in this file.
    call    ex_23_stretch_utf8_ascii_validate
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
