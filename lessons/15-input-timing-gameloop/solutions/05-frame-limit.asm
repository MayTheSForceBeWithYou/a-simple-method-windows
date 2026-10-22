; Exercise 05: frame limit
;
; If frame_time < min, pad; return pad amount 2.
;
; Build: ml64 /c 05-frame-limit.asm && link /OUT:05-frame-limit.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-frame-limit.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_05_frame_limit PROC
mov rax, 6
    mov rbx, 8
    cmp rax, rbx
    jge nopad
    mov rcx, rbx
    sub rcx, rax
    jmp exit_proc
nopad:
    xor rcx, rcx
exit_proc:

    ret
ex_05_frame_limit ENDP
main PROC
    sub     rsp, 40
    call    ex_05_frame_limit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
