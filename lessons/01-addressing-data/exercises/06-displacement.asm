; Exercise: 06-displacement
;
; Exercise 06: displacement
; struct-like: base label vals with QWORD 1,2,3. Load third qword via [vals+16] into rcx, exit.
;
; Contract: implement `ex_06_displacement` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

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
    sub     rsp, 40
    ; TODO: LEA RBX, arr
    ; TODO: MOV RAX, [RBX+8] to get second element
    ; TODO: Exit with RAX
    ; TODO: write ex_06_displacement in this file.
    call    ex_06_displacement
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
