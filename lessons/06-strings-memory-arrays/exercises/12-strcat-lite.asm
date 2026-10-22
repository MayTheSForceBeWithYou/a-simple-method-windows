; Exercise 12: 12-strcat-lite (Win32 port)
; dst has "Hi", append "!", len of dst after = 3; exit 3.
; Build: ml64 /c /Fo12-strcat-lite.obj 12-strcat-lite.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-strcat-lite.exe 12-strcat-lite.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_strcat_lite:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_12_strcat_lite (student routine; defined in solutions/).
    call    ex_12_strcat_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
