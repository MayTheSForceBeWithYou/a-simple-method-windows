; Exercise 15: clip rect
;
; Clip x to [0,w); x=-1 -> 0; exit 0.
;
; Build: ml64 /c 15-clip-rect.asm && link /OUT:15-clip-rect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-clip-rect.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_15_clip_rect PROC
    sub rsp, 40
    mov rax, -1
    cmp rax, 0
    jge check_hi
    xor rax, rax
check_hi:
    cmp rax, 10
    jl done_clip
    mov rax, 9
done_clip:
        add     rsp, 40
        ret
ex_15_clip_rect ENDP
main PROC
    sub     rsp, 40
    call    ex_15_clip_rect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
