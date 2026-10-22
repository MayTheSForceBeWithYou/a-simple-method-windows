; Exercise: 14-debug-div-rdx
;
; Exercise 14: debug div rdx
; BUG: forgot xor rdx,rdx before div. Fix; 100/10 quot exit 10.
;
; Contract: implement `ex_14_debug_div_rdx` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

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

__ex_call:
    ; TODO: write ex_14_debug_div_rdx in this file.
    call    ex_14_debug_div_rdx
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
