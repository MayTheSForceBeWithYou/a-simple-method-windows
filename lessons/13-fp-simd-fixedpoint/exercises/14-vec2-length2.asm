; Exercise: 14-vec2-length2
;
; Exercise 14: vec2 length2
; length^2 of (3,4)=25; exit 25.
;
; Contract: implement `ex_14_vec2_length2` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 25
;

; 14-vec2-length2
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_vec2_length2:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_vec2_length2 in this file.
    call    ex_14_vec2_length2
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
