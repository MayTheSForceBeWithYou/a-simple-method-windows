; Exercise 03: bss store
;
; BYTE ? in .data? (uninitialized). Store 7 into it, load into rcx, exit.
;
; Build: ml64 /c 03-bss-store.asm && link /OUT:03-bss-store.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-bss-store.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

.data?
slot BYTE ?

.code
main PROC
    sub rsp, 32
    mov BYTE PTR [slot], 7
    movzx rcx, BYTE PTR [slot]
    call ExitProcess
main ENDP
END
