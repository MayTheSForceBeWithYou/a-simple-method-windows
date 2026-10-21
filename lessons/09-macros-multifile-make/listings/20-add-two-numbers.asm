; Listing 20: add_two_numbers procedure (LESSON.md block 20)
;
; Link with 19-exit-with-macro.asm or 05-multifile-main.asm.

.CODE
PUBLIC add_two_numbers

add_two_numbers PROC
    mov rax, rcx
    add rax, rdx
    ret
add_two_numbers ENDP

END
