; Exercise 27: debug stack imbalance (Win32 port)
; BUG: extra push without pop before ret corrupts return. Fix; exit 2.
; Build: ml64 /c /Fo27-debug-stack-imbalance.obj 27-debug-stack-imbalance.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:27-debug-stack-imbalance.exe 27-debug-stack-imbalance.obj kernel32.lib
; Expected exit: 2

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_27_debug_stack_imbalance:PROC

two PROC
    mov rax, 2
    push rax                ; BUG: extra push before RET
    ret
two ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_debug_stack_imbalance in this file (balance stack around two).
    call    ex_27_debug_stack_imbalance
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
