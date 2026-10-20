; Exercise 10: word dword (Win32 port)
;
; Buffer in .DATA?. Store WORD 256, then load as DWORD (upper bits zero). Exit with it.
;
; Build: ml64 /c /Fo10-word-dword.obj 10-word-dword.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-word-dword.exe 10-word-dword.obj kernel32.lib
; Run: 10-word-dword.exe & echo %ERRORLEVEL%
;
; Expected: exit code 0 (256 is > 255, will be 0 in low byte)

.DATA?
buffer DQ ?

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; TODO: Store WORD PTR 256 to buffer
    ; TODO: Zero RAX, then load lower byte with MOVZX RCX, BYTE PTR [buffer]
    ; TODO: Exit with RCX
    ; Note: 256 = 0x0100, low byte is 0
    .ERR <TODO: Store word and load byte>
    
main ENDP

END
