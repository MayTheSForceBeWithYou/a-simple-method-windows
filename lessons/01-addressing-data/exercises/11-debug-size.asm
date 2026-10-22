; Exercise: 11-debug-size
;
; BUG: mov [buf], 1 ambiguous/wrong. Store BYTE 1, load movzx rcx, exit.
;
; Contract: implement `ex_11_debug_size` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.DATA?
buf BYTE ?

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_debug_size:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov [buf], 1    ; BUG: fix in ex_11_debug_size
    movzx rcx, BYTE PTR [buf]    ; BUG: fix in ex_11_debug_size

__ex_call:
    ; TODO: write ex_11_debug_size in this file.
    call    ex_11_debug_size
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
