; Exercise 14: debug div rdx
;
; BUG: forgot xor rdx,rdx before div. Fix; 100/10 quot exit 10.
;
; Build: ml64 /c 14-debug-div-rdx.asm && link /OUT:14-debug-div-rdx.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-debug-div-rdx.obj kernel32.lib
;
; Expected exit: 10


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_debug_div_rdx:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 100    ; BUG: fix in ex_14_debug_div_rdx
    mov rbx, 10    ; BUG: fix in ex_14_debug_div_rdx
    div rbx    ; BUG: fix in ex_14_debug_div_rdx
    mov rcx, rax    ; BUG: fix in ex_14_debug_div_rdx
    mov rax, 60    ; BUG: fix in ex_14_debug_div_rdx
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_14_debug_div_rdx in this file.
    call    ex_14_debug_div_rdx
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
