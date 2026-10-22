; Exercise: 01-keymap
;
; If key 'W' set flag; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_01_keymap PROC
    sub rsp, 40
    mov al, 'W'
    cmp al, 'W'
    jne not_match
    mov rcx, 1
    jmp exit_proc
not_match:
    xor rcx, rcx
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_keymap ENDP
main PROC
    sub     rsp, 40
    call    ex_01_keymap
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
