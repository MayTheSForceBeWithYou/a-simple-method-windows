; Exercise: 04-imul-two
;
; Exercise 04: imul two
; imul-style: rax=6, imul rax,7; mov rcx,rax; exit 42.
;
; Contract: implement `ex_04_imul_two` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; Exercise 04: imul two (Win32 port)
;
; RAX=6, RBX=7. IMUL RAX, RBX. Exit with 42.
;
; Build: ml64 /c /Fo04-imul-two.obj 04-imul-two.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-imul-two.exe 04-imul-two.obj kernel32.lib
; Run: 04-imul-two.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_imul_two:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_imul_two in this file.
    call    ex_04_imul_two
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
