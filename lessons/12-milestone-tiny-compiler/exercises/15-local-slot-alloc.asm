; 15-local-slot-alloc.asm: Allocate 3 local slots, exit count (3)
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_local_slot_alloc:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_local_slot_alloc in this file.
    call    ex_15_local_slot_alloc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
