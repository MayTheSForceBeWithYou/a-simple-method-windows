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
ex_03_bss_store PROC
    sub rsp, 40
    mov BYTE PTR [slot], 7
    movzx rcx, BYTE PTR [slot]
    mov     eax, 7
    add     rsp, 40
    ret
ex_03_bss_store ENDP
main PROC
    call    ex_03_bss_store
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
