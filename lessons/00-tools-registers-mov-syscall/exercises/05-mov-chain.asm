; Exercise 05: mov chain (Win32 port)
;
; Move 13 through RAX -> RBX -> RCX, then exit with RCX.
;
; Build: ml64 /c /Fo05-mov-chain.obj 05-mov-chain.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-mov-chain.exe 05-mov-chain.obj kernel32.lib
; Run: 05-mov-chain.exe & echo %ERRORLEVEL%
;
; Expected: exit code 13

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 13
    
    ; TODO: Move RAX to RBX, then RBX to RCX, then call ExitProcess
    .ERR <TODO: Complete the mov chain>
    
main ENDP

END
