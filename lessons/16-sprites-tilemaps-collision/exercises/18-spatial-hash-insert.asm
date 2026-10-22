; Exercise: 18-spatial-hash-insert
;
; Insert entity into cell bucket count++; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_18_spatial_hash_insert` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_spatial_hash_insert:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_spatial_hash_insert in this file.
    call    ex_18_spatial_hash_insert
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
