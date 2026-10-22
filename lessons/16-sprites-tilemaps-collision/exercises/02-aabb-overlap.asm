; Exercise: 02-aabb-overlap
;
; Overlap test true -> 1.
; Expected stdout: (none)
;
; Contract: implement `ex_02_aabb_overlap` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_02_aabb_overlap:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_aabb_overlap in this file.
    call    ex_02_aabb_overlap
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
