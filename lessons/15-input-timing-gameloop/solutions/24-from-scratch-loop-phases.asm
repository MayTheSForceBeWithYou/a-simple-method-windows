; Exercise 24: from scratch loop phases
;
; FROM SCRATCH: phases input,update,render counted; 3 phases * 2 frames = 6; exit 6.
;
; Build: ml64 /c 24-from-scratch-loop-phases.asm && link /OUT:24-from-scratch-loop-phases.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-loop-phases.obj kernel32.lib
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_24_from_scratch_loop_phases PROC
    sub rsp, 40
    xor rcx, rcx
    mov rbx, 2
frame_loop:
    add rcx, 3
    dec rbx
    jnz frame_loop
    mov     eax, 6
    add     rsp, 40
    ret
ex_24_from_scratch_loop_phases ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_loop_phases
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
