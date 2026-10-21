; Exercise 17: save header
;
; Write magic+version size 8; exit 8.
;
; Build: ml64 /c 17-save-header.asm && link /OUT:17-save-header.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-save-header.obj kernel32.lib
;
; Expected exit: 8
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 40
    mov rcx, 8
    call ExitProcess

main ENDP
END
