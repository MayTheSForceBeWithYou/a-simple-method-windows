; 15-local-slot-alloc.asm: Allocate 3 local slots, exit count (3)
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_local_slot_alloc:PROC
main PROC
    ; TODO: implement ex_15_local_slot_alloc (student routine; defined in solutions/).
    call    ex_15_local_slot_alloc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
