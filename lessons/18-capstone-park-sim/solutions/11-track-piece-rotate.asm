; Exercise 11: track piece rotate
;
; Rotate piece dir 0..3; 3+1 -> 0; exit 0.
;
; Build: ml64 /c 11-track-piece-rotate.asm && link /OUT:11-track-piece-rotate.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-track-piece-rotate.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [dir],3
    inc qword [dir]
    mov rax,[dir]
    and rax,3
    mov [dir],rax
    mov rcx, rax
    call ExitProcess

main ENDP
END
