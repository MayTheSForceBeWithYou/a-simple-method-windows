; Exercise 09: pointer walk (Win32 port)
;
; String DB "ABC",0. Load address, read first byte, increment pointer, read second byte. Exit with sum.
;
; Build: ml64 /c /Fo09-pointer-walk.obj 09-pointer-walk.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-pointer-walk.exe 09-pointer-walk.obj kernel32.lib
; Run: 09-pointer-walk.exe & echo %ERRORLEVEL%
;
; Expected exit: 131 (65+66 = 'A'+'B')

.DATA
walkMsg DB "ABC", 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_pointer_walk:PROC

main PROC
    sub     rsp, 32
    ; TODO: LEA RSI, walkMsg
    ; TODO: MOVZX RAX, BYTE PTR [RSI]   ; first byte
    ; TODO: INC RSI or ADD RSI, 1
    ; TODO: MOVZX RBX, BYTE PTR [RSI]   ; second byte
    ; TODO: ADD RAX, RBX and exit
    ; TODO: implement ex_09_pointer_walk (student routine; defined in solutions/).
    call    ex_09_pointer_walk
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
