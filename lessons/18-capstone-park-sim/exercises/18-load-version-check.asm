; 18-load-version-check: load version check
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_load_version_check:PROC
main PROC
    ; TODO: write ex_18_load_version_check in this file.
    call    ex_18_load_version_check
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
