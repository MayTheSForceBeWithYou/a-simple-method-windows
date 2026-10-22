; Exercise: 20-label-addresses
;
; Exercise 20: label addresses
; Two messages; print only msg2 "use me\n". Exit 0.
;
; Contract: implement `ex_20_label_addresses` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 20: label addresses
;
; Two messages; print only msg2 "use me\n". Exit 0.
;
; Build: ml64 /c 20-label-addresses.asm && link /OUT:20-label-addresses.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-label-addresses.obj kernel32.lib
;
; Expected exit: 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_20_label_addresses:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_20_label_addresses in this file.
    call    ex_20_label_addresses
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
