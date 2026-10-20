; Exercise 19: debug parent index
;
; BUG: parent[i] wrong. Fix reconstruct step count exit 2.
;
; Build: ml64 /c 19-debug-parent-index.asm && link /OUT:19-debug-parent-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-parent-index.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rcx, 2
    call ExitProcess

main ENDP
END
