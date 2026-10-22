; Exercise: 15-rec-strlen
;
; Exercise 15: rec strlen
; Recursive strlen("abcd")=4.
;
; Contract: implement `ex_15_rec_strlen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; Exercise 15: 15-rec-strlen.asm (Win32 port)
; Recursive strlen on "abcd"; exit 4.
; Build: ml64 /c /Fo15-rec-strlen.asm.obj 15-rec-strlen.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-rec-strlen.asm.exe 15-rec-strlen.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_rec_strlen:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_15_rec_strlen in this file.
    call    ex_15_rec_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
