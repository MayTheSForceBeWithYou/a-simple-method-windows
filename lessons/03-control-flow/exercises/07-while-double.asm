; Exercise: 07-while-double
;
; Exercise 07: while double
; rax=1; while rax<100 rax*=2; exit with final rax clamped: put rax in rcx then and 255; 128&255=128.
;
; Contract: implement `ex_07_while_double` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 128
;

; Exercise 07: while double
;
; rax=1; while rax<100 rax*=2; exit with final rax clamped: put rax in rcx then and 255; 128&255=128.
;
; Build: ml64 /c 07-while-double.asm && link /OUT:07-while-double.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-while-double.obj kernel32.lib
;
; Expected exit: 128


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_while_double:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_07_while_double in this file.
    call    ex_07_while_double
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
