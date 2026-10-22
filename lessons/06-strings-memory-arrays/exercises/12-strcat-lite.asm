; Exercise: 12-strcat-lite
;
; Exercise 12: strcat lite
; dst="Hi", append "!", final length=3.
;
; Contract: implement `ex_12_strcat_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; Exercise 12: 12-strcat-lite (Win32 port)
; dst has "Hi", append "!", len of dst after = 3; exit 3.
; Build: ml64 /c /Fo12-strcat-lite.obj 12-strcat-lite.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-strcat-lite.exe 12-strcat-lite.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_strcat_lite:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_12_strcat_lite in this file.
    call    ex_12_strcat_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
