; Exercise 06: lseek concept
;
; Without real file: simulate offset add; exit 10.
;
; Build: ml64 /c 06-lseek-concept.asm && link /OUT:06-lseek-concept.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-lseek-concept.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    
    ; Simulate offset calculation
    mov rcx, 0
    add rcx, 10
    
    call ExitProcess
main ENDP
END
