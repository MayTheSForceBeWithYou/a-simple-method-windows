; Exercise: 22-stretch-char-from-reg
;
; Exercise 22: stretch char from reg
; Set bl=05Ah ('Z'). Store into a 2-byte buffer (char + newline), write it, exit 0.
;
; Contract: implement `ex_22_stretch_char_from_reg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 22: stretch char from reg
;
; Set bl=05Ah ('Z'). Store into a 2-byte buffer (char + newline), write it, exit 0.
;
; Build: ml64 /c 22-stretch-char-from-reg.asm && link /OUT:22-stretch-char-from-reg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 22-stretch-char-from-reg.obj kernel32.lib
;
; Expected exit: 0

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_char_from_reg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_char_from_reg in this file.
    call    ex_22_stretch_char_from_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
