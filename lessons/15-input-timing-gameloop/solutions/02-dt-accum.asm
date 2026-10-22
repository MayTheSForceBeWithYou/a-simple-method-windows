; Exercise 02: dt accum
;
; accum+=dt; if >= step then tick++; exit ticks 2 for accum sim.
;
; Build: ml64 /c 02-dt-accum.asm && link /OUT:02-dt-accum.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-dt-accum.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_02_dt_accum PROC
xor rcx, rcx
    mov rax, 0
    add rax, 8
    add rax, 8
    mov rbx, 8
loop_start:
    cmp rax, rbx
    jl loop_done
    sub rax, rbx
    inc rcx
    jmp loop_start
loop_done:

    ret
ex_02_dt_accum ENDP
main PROC
    sub     rsp, 40
    call    ex_02_dt_accum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
