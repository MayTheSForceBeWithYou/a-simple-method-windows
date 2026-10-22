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

ex_15_camera_cull PROC
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
    mov     eax, 1
    ret
ex_15_camera_cull ENDP
main PROC
    sub     rsp, 40
    call    ex_15_camera_cull
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
