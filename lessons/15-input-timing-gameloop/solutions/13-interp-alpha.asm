; Exercise 13: interp alpha
;
; alpha = accum/step with accum=8 step=16 -> 0.5 as Q16 0x8000>>15 =1? Use alpha in 0..100 =50; exit 50.
;
; Build: ml64 /c 13-interp-alpha.asm && link /OUT:13-interp-alpha.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-interp-alpha.obj kernel32.lib
;
; Expected exit: 50
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_13_interp_alpha PROC
    sub rsp, 40
    mov rax, 8
    imul rax, 100
    xor rdx, rdx
    mov rbx, 16
    div rbx
        mov     eax, rax
    ret
    add     rsp, 40
ex_13_interp_alpha ENDP
main PROC
    call    ex_13_interp_alpha
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
