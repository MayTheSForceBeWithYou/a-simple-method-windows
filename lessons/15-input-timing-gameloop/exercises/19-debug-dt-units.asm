; Exercise: 19-debug-dt-units
;
; BUG: mixed ms/us. Fix treat 16000us as 16ms steps of 16 -> 1 step; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_19_debug_dt_units` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_dt_units:PROC

dt_units_bug PROC
    mov rax, 16000
    xor rdx, rdx
    mov rbx, 16                 ; BUG: divides microseconds by step size directly
    div rbx
    ret
dt_units_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_dt_units in this file.
    call    ex_19_debug_dt_units
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
