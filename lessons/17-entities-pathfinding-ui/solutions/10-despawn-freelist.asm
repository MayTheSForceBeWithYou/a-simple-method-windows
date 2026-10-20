; Exercise 10: despawn freelist
;
; Free id 3 onto freelist top; exit 3.
;
; Build: ml64 /c 10-despawn-freelist.asm && link /OUT:10-despawn-freelist.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-despawn-freelist.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [free_top],3
    mov rcx, [free_top]
    call ExitProcess

main ENDP
END
