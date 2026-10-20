; Exercise 17: debug inverted
;
; BUG: jl used where jg needed. rax=5 should take 'big' path exit 2.
;
; Build: ml64 /c 17-debug-inverted.asm && link /OUT:17-debug-inverted.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-debug-inverted.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 5
    cmp rax, 3
    jg big
    mov rcx, 1
    jmp out
big:
    mov rcx, 2
out:
    call ExitProcess
main ENDP
END
