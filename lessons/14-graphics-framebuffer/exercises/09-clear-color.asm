; Exercise: 09-clear-color
;
; Exercise 09: clear color
; Clear 4 pixels to color 5; exit first.
; Expected stdout: (none)
;
; Contract: implement `ex_09_clear_color` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; 09-clear-color: clear color
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_clear_color:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_clear_color in this file.
    call    ex_09_clear_color
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
