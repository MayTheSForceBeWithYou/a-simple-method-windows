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

ex_04_edge_trigger PROC
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
    ; return value already in EAX/RAX
    ret
ex_04_edge_trigger ENDP
main PROC
    sub     rsp, 40
    call    ex_04_edge_trigger
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
