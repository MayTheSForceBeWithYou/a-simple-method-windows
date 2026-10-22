; Exercise: 24-from-scratch-reverse-string
;
; Exercise 24: from scratch reverse string
; FROM SCRATCH: reverse "asm" in place; first byte should be "m"=109.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_reverse_string` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 109
;

; Exercise 24: 24-from-scratch-reverse-string (Win32 port)
; FROM SCRATCH: reverse "asm" in place; first byte should be "m"=109.
; Build: ml64 /c /Fo24-from-scratch-reverse-string.obj 24-from-scratch-reverse-string.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:24-from-scratch-reverse-string.exe 24-from-scratch-reverse-string.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_reverse_string:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_24_from_scratch_reverse_string in this file.
    call    ex_24_from_scratch_reverse_string
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
