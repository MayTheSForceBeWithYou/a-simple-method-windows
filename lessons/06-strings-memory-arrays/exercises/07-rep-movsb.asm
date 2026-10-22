; Exercise: 07-rep-movsb
;
; Exercise 07: rep movsb
; Copy 5 bytes [1..5]; sum=15.
;
; Contract: implement `ex_07_rep_movsb` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;

; Exercise 07: 07-rep-movsb (Win32 port)
; Copy 5 bytes with rep movsb; checksum exit 15 for bytes 1..5.
; Build: ml64 /c /Fo07-rep-movsb.obj 07-rep-movsb.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-rep-movsb.exe 07-rep-movsb.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_rep_movsb:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_07_rep_movsb in this file.
    call    ex_07_rep_movsb
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
