; Exercise 21: formation slot
;
; Slot index 2 offset; exit 2.
;
; Build: ml64 /c 21-formation-slot.asm && link /OUT:21-formation-slot.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-formation-slot.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
ex_21_formation_slot PROC
    sub rsp, 40
        mov     eax, 2
    add     rsp, 40
    ret
ex_21_formation_slot ENDP
main PROC
    call    ex_21_formation_slot
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
