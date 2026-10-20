; Exercise 09: pointer walk (Win32 port) - SOLUTION
;
; String DB "ABC",0. Load address, read first byte, increment pointer, read second byte. Exit with sum.
;
; Build: ml64 /c /Fo09-pointer-walk.obj 09-pointer-walk.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-pointer-walk.exe 09-pointer-walk.obj kernel32.lib
; Run: 09-pointer-walk.exe & echo %ERRORLEVEL%
;
; Expected: exit code 131 (65+66 = 'A'+'B')

.DATA
str DB "ABC", 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    lea rsi, str
    movzx rax, BYTE PTR [rsi]  ; First byte ('A' = 65)
    inc rsi
    movzx rbx, BYTE PTR [rsi]  ; Second byte ('B' = 66)
    add rax, rbx               ; Sum = 131
    mov rcx, rax
    call ExitProcess
    
main ENDP

END
