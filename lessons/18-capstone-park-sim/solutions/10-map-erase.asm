; Exercise 10: map erase
;
; Erase cell to EMPTY=0; exit 0.
;
; Build: ml64 /c 10-map-erase.asm && link /OUT:10-map-erase.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-map-erase.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov byte [map+5],1
    mov byte [map+5],0
    movzx rdi,byte [map+5]
    mov rax,60
    syscall

main ENDP
END
