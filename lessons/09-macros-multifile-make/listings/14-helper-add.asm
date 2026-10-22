; Listing 14: helper_add procedure object (LESSON.md block 14)
;
; Link with 16-main-call-helper.asm (same as 05-multifile pattern).

.CODE
PUBLIC helper_add

helper_add PROC
    mov rax, rcx
    add rax, rdx
    ret
helper_add ENDP

END
