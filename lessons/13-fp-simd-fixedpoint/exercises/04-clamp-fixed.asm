; Exercise: 04-clamp-fixed
;
; Exercise 04: clamp fixed
; Clamp Q16.16 value 10<<16 to max 8<<16; exit 8.
;
; Contract: implement `ex_04_clamp_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;

; 04-clamp-fixed.asm: Clamp value to [0, max], exit clamped
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_clamp_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_clamp_fixed in this file.
    call    ex_04_clamp_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
