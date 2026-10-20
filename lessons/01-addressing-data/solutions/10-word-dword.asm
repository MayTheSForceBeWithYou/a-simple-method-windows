; Exercise 10: word dword (Win32 port) - SOLUTION
;
; Buffer in .DATA?. Store WORD 256, then load as byte (upper bits zero). Exit with it.
;
; Build: ml64 /c /Fo10-word-dword.obj 10-word-dword.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-word-dword.exe 10-word-dword.obj kernel32.lib
; Run: 10-word-dword.exe & echo %ERRORLEVEL%
;
; Expected: exit code 0 (256 = 0x0100, low byte is 0)

.DATA?
buffer DQ ?

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    lea rbx, buffer
    mov WORD PTR [rbx], 256    ; 256 = 0x0100 (little-endian: 00 01)
    movzx rcx, BYTE PTR [rbx]  ; Load low byte (0)
    call ExitProcess
    
main ENDP

END
