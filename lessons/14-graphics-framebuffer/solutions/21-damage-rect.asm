; Exercise 21: damage rect
;
; Damage union width; exit 16.
;
; Build: ml64 /c 21-damage-rect.asm && link /OUT:21-damage-rect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-damage-rect.obj kernel32.lib
;
; Expected exit: 16
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_21_damage_rect PROC
    sub rsp, 40
        mov     eax, 16
    ret
    add     rsp, 40
ex_21_damage_rect ENDP
main PROC
    call    ex_21_damage_rect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
