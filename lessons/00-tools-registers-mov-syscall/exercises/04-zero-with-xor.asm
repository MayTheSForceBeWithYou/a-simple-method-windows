; Exercise 04: zero with xor (Win32 port)
;
; Use the XOR idiom to zero RCX, then exit with that status.
;
; Build: ml64 /c /Fo04-zero-with-xor.obj 04-zero-with-xor.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-zero-with-xor.exe 04-zero-with-xor.obj kernel32.lib
; Run: 04-zero-with-xor.exe & echo %ERRORLEVEL%
;
; Expected: exit code 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_zero_with_xor:PROC

main PROC
    sub     rsp, 40
    ; TODO: Use XOR to zero RCX (not mov rcx, 0), then call ExitProcess
    ; TODO: write ex_04_zero_with_xor in this file.
    call    ex_04_zero_with_xor
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
