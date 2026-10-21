; Exercise 15: camera cull
;
; Sprite x=100 cam=50 view_w=40 -> culled; exit 1.
;
; Build: ml64 /c 15-camera-cull.asm && link /OUT:15-camera-cull.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-camera-cull.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 100
    sub rax, 50
    cmp rax, 40
    jl visible
    mov rcx, 1
    jmp exit_proc
visible:
    xor rcx, rcx
exit_proc:
    call ExitProcess
main ENDP
END
