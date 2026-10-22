; Exercise: 16-debug-callee-clobber
;
; Exercise 16: debug callee clobber
; BUG fixed: preserve rbx. Exit 11.
;
; Contract: implement `ex_16_debug_callee_clobber` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 11
;

; Exercise 16: debug callee clobber (Win32 port)
; BUG: callee clobbers RBX without saving. Fix by adding PUSH/POP. Exit 11.
; Build: ml64 /c /Fo16-debug-callee-clobber.obj 16-debug-callee-clobber.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:16-debug-callee-clobber.exe 16-debug-callee-clobber.obj kernel32.lib
; Expected exit: 11
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_debug_callee_clobber:PROC

helper PROC
    ; BUG: uses RBX without saving (nonvolatile in MS x64)
    mov rbx, 99
    mov rax, 1
    ret
helper ENDP

main PROC
    sub     rsp, 40
    mov     rbx, 11
    ; TODO: write ex_16_debug_callee_clobber in this file (fix helper, preserve rbx, exit 11).
    call    ex_16_debug_callee_clobber
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
