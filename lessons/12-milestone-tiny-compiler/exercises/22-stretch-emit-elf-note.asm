; 22-stretch-emit-elf-note.asm: Track ELF note section size, exit size
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_emit_elf_note:PROC
main PROC
    ; TODO: write ex_22_stretch_emit_elf_note in this file.
    call    ex_22_stretch_emit_elf_note
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
