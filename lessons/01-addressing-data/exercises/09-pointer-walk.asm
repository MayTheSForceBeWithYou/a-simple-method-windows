; Exercise 09: pointer walk (Win32 port)
;
; String DB "ABC",0. Load address, read first byte, increment pointer, read second byte. Exit with sum.
;
; Build: ml64 /c /Fo09-pointer-walk.obj 09-pointer-walk.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-pointer-walk.exe 09-pointer-walk.obj kernel32.lib
; Run: 09-pointer-walk.exe & echo %ERRORLEVEL%
;
; Expected exit: 131 (65+66 = 'A'+'B')

.DATA
str DB "ABC", 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; TODO: LEA RSI, str
    ; TODO: MOVZX RAX, BYTE PTR [RSI]   ; first byte
    ; TODO: INC RSI or ADD RSI, 1
    ; TODO: MOVZX RBX, BYTE PTR [RSI]   ; second byte
    ; TODO: ADD RAX, RBX and exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
