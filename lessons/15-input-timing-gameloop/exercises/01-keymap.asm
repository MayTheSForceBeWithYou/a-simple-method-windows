; Exercise: 01-keymap
;
; If key 'W' set flag; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_01_keymap` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_keymap:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_keymap in this file.
    call    ex_01_keymap
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
