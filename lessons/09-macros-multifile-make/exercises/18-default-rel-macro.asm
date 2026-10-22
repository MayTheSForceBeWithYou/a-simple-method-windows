; Exercise: 18-default-rel-macro
;
; MASM RIP-relative addressing (default in 64-bit); lea rdx,[msg]; write hi; exit 0.
; Expected stdout: "hi\n"
;
; Contract: implement `ex_18_default_rel_macro` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.DATA
msg DB "hi", 13, 10
msgLen EQU $ - msg
written DWORD ?

.CODE
EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC
EXTRN ex_18_default_rel_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_default_rel_macro in this file.
    call    ex_18_default_rel_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
