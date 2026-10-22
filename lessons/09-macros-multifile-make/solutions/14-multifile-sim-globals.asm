; Exercise 14: multifile sim globals
;
; Simulate module: PUBLIC helper_add; call with 20,22 exit 42.
;
; Build: ml64 /c 14-multifile-sim-globals.asm && link /OUT:14-multifile-sim-globals.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-multifile-sim-globals.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

; In MASM, PUBLIC makes symbols visible to other modules
PUBLIC helper_add

.code
ex_14_multifile_sim_globals PROC
    sub rsp, 40
    
    mov rcx, 20
    mov rdx, 22
    call helper_add
    
        mov     eax, rax
    ret
    add     rsp, 40
ex_14_multifile_sim_globals ENDP
main PROC
    call    ex_14_multifile_sim_globals
    mov     rcx, rax
    call    ExitProcess
main ENDP

helper_add PROC
    ; MS x64 ABI: args in RCX, RDX
    mov rax, rcx
    add rax, rdx
    ret
helper_add ENDP
END
