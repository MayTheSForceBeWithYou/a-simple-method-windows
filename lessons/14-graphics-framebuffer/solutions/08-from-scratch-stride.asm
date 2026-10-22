; Exercise 08: from scratch stride
;
; FROM SCRATCH: stride=width*bpp; w=16 bpp=4; exit 64.
;
; Build: ml64 /c 08-from-scratch-stride.asm && link /OUT:08-from-scratch-stride.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-stride.obj kernel32.lib
;
; Expected exit: 64
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_stride PROC
    sub rsp, 40
    mov rcx, 16
    imul rcx, 4
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_stride ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_stride
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
