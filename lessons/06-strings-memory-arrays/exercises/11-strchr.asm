; Exercise: 11-strchr
;
; Exercise 11: strchr
; Find 'l' in 'hello' -> index 2.
;
; Contract: implement `ex_11_strchr` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 11: 11-strchr (Win32 port)
; Find index of "l" in "hello" -> 2.
; Build: ml64 /c /Fo11-strchr.obj 11-strchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-strchr.exe 11-strchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_strchr:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_11_strchr in this file.
    call    ex_11_strchr
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
