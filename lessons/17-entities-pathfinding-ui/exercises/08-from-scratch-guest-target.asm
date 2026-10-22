; 08-from-scratch-guest-target: from scratch guest target
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_guest_target:PROC
main PROC
    ; TODO: write ex_08_from_scratch_guest_target in this file.
    call    ex_08_from_scratch_guest_target
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
