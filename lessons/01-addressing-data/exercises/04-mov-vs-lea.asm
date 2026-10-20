; Exercise 04: mov vs lea (Win32 port)
;
; Label x DQ 99. LEA RBX,[x] then MOV RAX,[RBX]. Exit with 99.
; Add comments explaining which instruction computes address vs loads value.
;
; Build: ml64 /c /Fo04-mov-vs-lea.obj 04-mov-vs-lea.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-mov-vs-lea.exe 04-mov-vs-lea.obj kernel32.lib
; Run: 04-mov-vs-lea.exe & echo %ERRORLEVEL%
;
; Expected: exit code 99

.DATA
x DQ 99

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; TODO: Use LEA to load address of x into RBX
    ; TODO: Use MOV to load value from [RBX] into RAX
    ; TODO: Move RAX to RCX and exit
    .ERR <TODO: Implement LEA, MOV, and exit>
    
main ENDP

END
