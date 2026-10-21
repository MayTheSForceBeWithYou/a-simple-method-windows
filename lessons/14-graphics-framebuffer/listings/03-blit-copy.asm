; Listing rule: code using rep movs* must run cld before the string op and before ret
; Expected exit: 0
; Expected stdout: (none)
; (MS x64 ABI guarantees DF clear on function entry and return; do not assume DF=0 across calls).
;
; Copy sprite to framebuffer, exit 0
.DATA
sprite DD 1, 2, 3, 4
.DATA?
fb DB 640*480*4 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    lea rsi, sprite
    lea rdi, fb
    mov ecx, 4
    rep movsd
    xor ecx, ecx
    call ExitProcess
main ENDP
END
