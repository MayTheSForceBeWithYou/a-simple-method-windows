; Exercise 01: keymap
;
; If key 'W' set flag; exit 1.
;
; Build: ml64 /c 01-keymap.asm && link /OUT:01-keymap.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-keymap.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

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
    mov     eax, 1
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
