; Exercise: 14-arena-align
;
; Exercise 14: arena align
; Bump 1 then align to 8; bump becomes 8; exit 8.
;
; Contract: implement `ex_14_arena_align` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;

; 14-arena-align
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_arena_align:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_arena_align in this file.
    call    ex_14_arena_align
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
