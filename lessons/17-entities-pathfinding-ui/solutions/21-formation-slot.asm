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
    
main PROC
    sub rsp, 32
    mov rcx, 2
    call ExitProcess

main ENDP
END
