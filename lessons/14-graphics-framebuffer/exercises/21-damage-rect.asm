; Exercise: 21-damage-rect
;
; Damage union width; exit 16.
; Expected stdout: (none)
;
; Contract: implement `ex_21_damage_rect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 16
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_damage_rect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_damage_rect in this file.
    call    ex_21_damage_rect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
