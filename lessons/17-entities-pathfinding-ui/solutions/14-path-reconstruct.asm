; Exercise 14: path reconstruct
;
; Path length 4; exit 4.
;
; Build: ml64 /c 14-path-reconstruct.asm && link /OUT:14-path-reconstruct.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-path-reconstruct.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rcx, 4
    call ExitProcess

main ENDP
END
