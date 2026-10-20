; Exercise 23: stretch multiplayer stub
;
; STRETCH: net tick id 2; exit 2. (local stub)
;
; Build: ml64 /c 23-stretch-multiplayer-stub.asm && link /OUT:23-stretch-multiplayer-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-multiplayer-stub.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [tick_id],2
    mov rcx, [tick_id]
    call ExitProcess

main ENDP
END
