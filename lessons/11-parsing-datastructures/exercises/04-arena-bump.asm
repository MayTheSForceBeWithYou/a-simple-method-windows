; Exercise: 04-arena-bump
;
; Bump allocate 16 then 16; offset 32; exit 32&255.
;
; Contract: implement `ex_04_arena_bump` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 32
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_04_arena_bump:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_arena_bump in this file.
    call    ex_04_arena_bump
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
