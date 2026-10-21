; Exercise 04: edge trigger
;
; prev=0 cur=1 -> rising exit 1.
;
; Build: ml64 /c 04-edge-trigger.asm && link /OUT:04-edge-trigger.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-edge-trigger.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov eax, 0
    mov ebx, 1
    cmp eax, 0
    jne not_rising
    cmp ebx, 1
    jne not_rising
    mov rcx, 1
    jmp exit_proc
not_rising:
    xor rcx, rcx
exit_proc:
    call ExitProcess
main ENDP
END
