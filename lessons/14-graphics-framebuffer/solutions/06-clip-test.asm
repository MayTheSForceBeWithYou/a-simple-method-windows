; Exercise 06: clip test
;
; x=5 w=4 -> outside exit 1.
;
; Build: ml64 /c 06-clip-test.asm && link /OUT:06-clip-test.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-clip-test.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_06_clip_test PROC
mov rax, 5
    cmp rax, 4
    jl in_range
    mov rcx, 1
    jmp exit_proc
in_range:
    xor rcx, rcx
exit_proc:

    ret
ex_06_clip_test ENDP
main PROC
    sub     rsp, 40
    call    ex_06_clip_test
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
