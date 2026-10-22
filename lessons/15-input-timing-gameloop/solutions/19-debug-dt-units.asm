; Exercise 19: debug dt units
;
; BUG: mixed ms/us. Fix treat 16000us as 16ms steps of 16 -> 1 step; exit 1.
;
; Build: ml64 /c 19-debug-dt-units.asm && link /OUT:19-debug-dt-units.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-dt-units.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_19_debug_dt_units PROC
    sub rsp, 40
    mov rax, 16000
    xor rdx, rdx
    mov rbx, 1000
    div rbx
    xor rdx, rdx
    mov rbx, 16
    div rbx
        mov     eax, rax
    ret
    add     rsp, 40
ex_19_debug_dt_units ENDP
main PROC
    call    ex_19_debug_dt_units
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
