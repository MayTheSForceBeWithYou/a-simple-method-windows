; Exercise 19: debug map bounds
;
; BUG: no bounds check. Clamp x=99 to w-1=7; exit 7.
;
; Build: ml64 /c 19-debug-map-bounds.asm && link /OUT:19-debug-map-bounds.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-map-bounds.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov rax,99
    mov rbx,8
    cmp rax,rbx
    jl .ok
    mov rax,rbx
    dec rax
.ok:
    mov rcx, rax
    call ExitProcess

main ENDP
END
