; Exercise: 18-debug-off-by-one-copy
;
; BUG: copies n bytes but forgets NUL. Fix strcpy of "ok"; strlen=2.
; Expected stdout: (none)
;
; Contract: implement `ex_18_debug_off_by_one_copy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.DATA
src BYTE "ok", 0

.DATA?
dst BYTE 8 DUP(?)

.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_18_debug_off_by_one_copy:PROC

strcpy_n PROC
    ; BUG: copies exactly two bytes, no terminating NUL
    mov al, BYTE PTR [rdx]
    mov BYTE PTR [rcx], al
    mov al, BYTE PTR [rdx+1]
    mov BYTE PTR [rcx+1], al
    ret
strcpy_n ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_debug_off_by_one_copy in this file (NUL-terminated strcpy).
    call    ex_18_debug_off_by_one_copy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
