; Exercise: 12-aabb-minkowski
;
; Exercise 12: aabb minkowski
; Minkowski expand by 1; width 4->6; exit 6.
; Expected stdout: (none)
;
; Contract: implement `ex_12_aabb_minkowski` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;

; 12-aabb-minkowski: aabb minkowski
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_aabb_minkowski:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_aabb_minkowski in this file.
    call    ex_12_aabb_minkowski
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
