; Listing 02: Multi-local stack frame (lines 14-40 of LESSON.md)
;
; Purpose: sum_locals(n) stores n, n+1, n+2 as locals and returns sum.
; Expected exit code: 33 (10+11+12)
; Expected output: (none)
;
; Build: ml64 /c /Fo02-multi-local-frame.obj 02-multi-local-frame.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-multi-local-frame.exe 02-multi-local-frame.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_locals PROC FRAME
    push rbp
    .pushreg rbp
    mov rbp, rsp
    sub rsp, 32                ; 24 bytes locals + 8 alignment
    .allocstack 32
    .endprolog
    
    mov [rbp-8], rcx           ; local1 = n
    lea rax, [rcx+1]
    mov [rbp-16], rax          ; local2 = n+1
    lea rax, [rcx+2]
    mov [rbp-24], rax          ; local3 = n+2
    
    mov rax, [rbp-8]
    add rax, [rbp-16]
    add rax, [rbp-24]
    
    leave
    ret
sum_locals ENDP

main PROC
    sub rsp, 32
    mov rcx, 10
    call sum_locals
    mov rcx, rax
    call ExitProcess
main ENDP

END
