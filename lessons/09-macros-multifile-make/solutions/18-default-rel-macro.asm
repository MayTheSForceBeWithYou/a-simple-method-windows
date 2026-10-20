; Exercise 18: default rel macro
;
; MASM RIP-relative addressing (default in 64-bit); lea rdx,[msg]; write hi; exit 0.
;
; Build: ml64 /c 18-default-rel-macro.asm && link /OUT:18-default-rel-macro.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-default-rel-macro.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: "hi\n"

EXTERN GetStdHandle:PROC
EXTERN WriteFile:PROC
EXTERN ExitProcess:PROC

.data
msg BYTE "hi", 10
msg_len EQU $ - msg

.data?
written DWORD ?

.code
main PROC
    sub rsp, 56
    
    ; Get stdout handle
    mov rcx, -11
    call GetStdHandle
    
    ; Write message (MASM uses RIP-relative by default)
    mov rcx, rax
    lea rdx, [msg]      ; RIP-relative addressing is automatic in MASM x64
    mov r8d, msg_len
    lea r9, written
    mov QWORD PTR [rsp+32], 0
    call WriteFile
    
    ; Exit 0
    mov rcx, 0
    call ExitProcess
main ENDP
END
