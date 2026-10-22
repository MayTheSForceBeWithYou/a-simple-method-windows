; Exercise: 15-debug-wrong-arg-reg
;
; Exercise 15: debug wrong arg reg
; BUG fixed: use rdx. add(2,40)=42. MS x64 ABI.
;
; Contract: implement `ex_15_debug_wrong_arg_reg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; Exercise 15: debug wrong arg reg (Win32 port)
; BUG: second arg in wrong register. add(2,40) should=42. Fix MS x64 arg regs.
; Build: ml64 /c /Fo15-debug-wrong-arg-reg.obj 15-debug-wrong-arg-reg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-debug-wrong-arg-reg.exe 15-debug-wrong-arg-reg.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_debug_wrong_arg_reg:PROC

add2 PROC
    mov rax, rcx
    add rax, rdx
    ret
add2 ENDP

main PROC
    sub     rsp, 40
    mov     rcx, 2
    mov     rsi, 40                ; BUG: second arg must be in RDX for add2
    ; TODO: write ex_15_debug_wrong_arg_reg in this file (correct arg regs, call add2).
    call    ex_15_debug_wrong_arg_reg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
