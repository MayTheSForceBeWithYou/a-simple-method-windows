; Exercise 06: displacement (Win32 port)
;
; Array of 3 DQs: [5, 15, 25]. Load base into RBX, access element at offset 8 with [RBX+8].
;
; Build: ml64 /c /Fo06-displacement.obj 06-displacement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-displacement.exe 06-displacement.obj kernel32.lib
; Run: 06-displacement.exe & echo %ERRORLEVEL%
;
; Expected exit: 15
; Expected stdout: (none)
.DATA
arr DQ 5, 15, 25

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_displacement:PROC

main PROC
    sub     rsp, 32
    ; TODO: LEA RBX, arr
    ; TODO: MOV RAX, [RBX+8] to get second element
    ; TODO: Exit with RAX
    ; TODO: implement ex_06_displacement (student routine; defined in solutions/).
    call    ex_06_displacement
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
