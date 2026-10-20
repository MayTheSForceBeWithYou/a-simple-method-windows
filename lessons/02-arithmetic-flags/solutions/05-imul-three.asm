; Exercise 05: imul three
;
; Set rcx=6 then imul rcx,7. Exit 42.
;
; Build: ml64 /c 05-imul-three.asm && link /OUT:05-imul-three.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-imul-three.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 6
    imul rcx, 7
    call ExitProcess
main ENDP
END
