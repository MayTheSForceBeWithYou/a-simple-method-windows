; Exercise 16: debug missing pop
; BUG HUNT: recursive fact-like leaves stack unbalanced. Fix; fact(3)=6 exit 6.
; Build: ml64 /c /Fo16-debug-missing-pop.obj 16-debug-missing-pop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-debug-missing-pop.exe 16-debug-missing-pop.obj kernel32.lib
; Expected exit: 6

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_debug_missing_pop:PROC

fact PROC
    cmp rcx, 1
    jle fact_base
    push rcx
    sub rsp, 40
    dec rcx
    call fact
    add rsp, 40
    ; BUG: missing POP RCX before IMUL
    imul rax, rcx
    ret
fact_base:
    mov rax, 1
    ret
fact ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_debug_missing_pop in this file (balanced fact).
    call    ex_16_debug_missing_pop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
