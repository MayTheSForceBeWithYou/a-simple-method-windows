; Exercise 22: stretch emit elf note
;
; STRETCH: document emitting ELF; exit header size stub 64.
; Expected exit: 64

EXTERN ExitProcess:PROC

.code

ex_22_stretch_emit_elf_note PROC
mov rcx, 64
    mov     eax, ecx
    ret
ex_22_stretch_emit_elf_note ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_emit_elf_note
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
