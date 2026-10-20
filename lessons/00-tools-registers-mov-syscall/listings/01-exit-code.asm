; Listing 01: Exit with status code
;
; Purpose: Demonstrates the minimal Win32 program that exits with a specific status.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo01-exit-code.obj 01-exit-code.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-exit-code.exe 01-exit-code.obj kernel32.lib
; Run: 01-exit-code.exe & echo %ERRORLEVEL%

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov ecx, 42                ; Exit status in RCX (first argument, MS x64 ABI)
    sub rsp, 32                ; Shadow space (32 bytes required by ABI)
    call ExitProcess           ; Never returns
main ENDP

END
