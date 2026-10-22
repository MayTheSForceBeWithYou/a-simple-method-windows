; Exercise: 04-mov-vs-lea
;
; Exercise 04: mov vs lea
; Label x QWORD 99. lea rbx,[x] then mov rcx,[rbx]. Exit with 99. Comment which is address vs load.
;
; Contract: implement `ex_04_mov_vs_lea` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 99
;

; Exercise 04: mov vs lea (Win32 port)
;
; Label x DQ 99. LEA RBX,[x] then MOV RAX,[RBX]. Exit with 99.
; Add comments explaining which instruction computes address vs loads value.
;
; Build: ml64 /c /Fo04-mov-vs-lea.obj 04-mov-vs-lea.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-mov-vs-lea.exe 04-mov-vs-lea.obj kernel32.lib
; Run: 04-mov-vs-lea.exe & echo %ERRORLEVEL%
;
; Expected exit: 99
; Expected stdout: (none)
.DATA
x DQ 99

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_mov_vs_lea:PROC

main PROC
    sub     rsp, 40
    ; TODO: Use LEA to load address of x into RBX
    ; TODO: Use MOV to load value from [RBX] into RAX
    ; TODO: Move RAX to RCX and exit
    ; TODO: write ex_04_mov_vs_lea in this file.
    call    ex_04_mov_vs_lea
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
