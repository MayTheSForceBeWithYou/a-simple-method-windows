; Exercise: 10-despawn-freelist
;
; Exercise 10: despawn freelist
; Free id 3 onto freelist top; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_10_despawn_freelist` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; 10-despawn-freelist: despawn freelist
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_despawn_freelist:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_despawn_freelist in this file.
    call    ex_10_despawn_freelist
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
