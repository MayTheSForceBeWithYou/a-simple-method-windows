; Exercise 07: clip w
;
; sprite w clipped; exit 2.
;
; Build: ml64 /c 07-clip-w.asm && link /OUT:07-clip-w.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-clip-w.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_07_clip_w PROC
    sub rsp, 40
        mov     eax, 2
    ret
    add     rsp, 40
ex_07_clip_w ENDP
main PROC
    call    ex_07_clip_w
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
