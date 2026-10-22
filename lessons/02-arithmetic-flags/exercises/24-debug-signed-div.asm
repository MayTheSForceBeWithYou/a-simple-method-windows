; Exercise: 24-debug-signed-div
;
; BUG: used xor rdx,rdx before idiv of negative. Fix with cqo. (-20)/3 quot -6.
;
; Contract: implement `ex_24_debug_signed_div` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_24_debug_signed_div:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, -20    ; BUG: fix in ex_24_debug_signed_div
    xor rdx, rdx    ; BUG: fix in ex_24_debug_signed_div
    mov rbx, 3    ; BUG: fix in ex_24_debug_signed_div
    idiv rbx    ; BUG: fix in ex_24_debug_signed_div
    mov rcx, rax    ; BUG: fix in ex_24_debug_signed_div
    add rdi, 6    ; BUG: fix in ex_24_debug_signed_div

__ex_call:
    ; TODO: write ex_24_debug_signed_div in this file.
    call    ex_24_debug_signed_div
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
