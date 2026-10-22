; Exercise: 13-memcpy-overlap-safe
;
; Copy 8 bytes forward non-overlap; checksum low byte sum of dst. src 1..8 sum=36.
; Expected stdout: (none)
;
; Contract: implement `ex_13_memcpy_overlap_safe` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 36
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_memcpy_overlap_safe:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_13_memcpy_overlap_safe in this file.
    call    ex_13_memcpy_overlap_safe
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
