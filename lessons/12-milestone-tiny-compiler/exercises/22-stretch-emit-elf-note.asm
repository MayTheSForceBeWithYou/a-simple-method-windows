; 22-stretch-emit-elf-note.asm: Track ELF note section size, exit size
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_emit_elf_note:PROC
main PROC
    ; TODO: implement ex_22_stretch_emit_elf_note (student routine; defined in solutions/).
    call    ex_22_stretch_emit_elf_note
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
