; Exercise 15: getpid
;
; GetCurrentProcessId; exit pid&0x7f (nonzero usually).
;
; Build: ml64 /c 15-getpid.asm && link /OUT:15-getpid.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-getpid.obj kernel32.lib
;
; Expected exit: (varies, usually nonzero)

EXTERN GetCurrentProcessId:PROC
EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    
    ; GetCurrentProcessId returns DWORD
    call GetCurrentProcessId
    
    ; Mask to low 7 bits
    and rax, 07Fh
    
    ; Exit with masked PID
    mov rcx, rax
    call ExitProcess
main ENDP
END
