; Exercise: 14-blit-key
;
; Exercise 14: blit key
; Blit with color key 0 skip; src 0,5,0,5 -> dst sum 10.
; Expected stdout: (none)
;
; Contract: implement `ex_14_blit_key` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; 14-blit-key: blit key
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_blit_key:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_blit_key in this file.
    call    ex_14_blit_key
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
