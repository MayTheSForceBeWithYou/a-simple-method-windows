; Exercise 02: inc dec (Win32 port)
;
; RAX=0; inc 5 times; dec 2 times; exit (3).
;
; Build: ml64 /c /Fo02-inc-dec.obj 02-inc-dec.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-inc-dec.exe 02-inc-dec.obj kernel32.lib
; Run: 02-inc-dec.exe & echo %ERRORLEVEL%
;
; Expected exit: 3
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax
    
    ; TODO: INC 5 times, DEC 2 times, exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
