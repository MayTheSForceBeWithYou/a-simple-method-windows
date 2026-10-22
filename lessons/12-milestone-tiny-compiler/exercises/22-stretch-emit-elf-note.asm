; Exercise: 22-stretch-emit-elf-note
;
; STRETCH: document emitting ELF; exit header size stub 64.
;
; Contract: implement `ex_22_stretch_emit_elf_note` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 64
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_emit_elf_note:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_emit_elf_note in this file.
    call    ex_22_stretch_emit_elf_note
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
