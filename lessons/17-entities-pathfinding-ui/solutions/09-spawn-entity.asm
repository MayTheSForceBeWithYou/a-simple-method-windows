; Exercise 09: spawn entity
;
; Bump entity id; first spawn id=1; exit 1.
;
; Build: ml64 /c 09-spawn-entity.asm && link /OUT:09-spawn-entity.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-spawn-entity.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    inc qword [next_id]
    mov rcx, [next_id]
    call ExitProcess

main ENDP
END
