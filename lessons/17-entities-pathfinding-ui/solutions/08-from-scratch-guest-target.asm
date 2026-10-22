; Exercise 08: from scratch guest target
;
; FROM SCRATCH: guest target id 7; exit 7.
;
; Build: ml64 /c 08-from-scratch-guest-target.asm && link /OUT:08-from-scratch-guest-target.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-guest-target.obj kernel32.lib
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_guest_target PROC
    sub rsp, 40
    call ExitProcess
    mov     eax, 7
    add     rsp, 40
    ret
ex_08_from_scratch_guest_target ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_guest_target
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
