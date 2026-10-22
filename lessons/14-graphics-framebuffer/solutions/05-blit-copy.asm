; Exercise 05: blit copy
;
; Copy 4 bytes src->dst; sum exit 10.
;
; Build: ml64 /c 05-blit-copy.asm && link /OUT:05-blit-copy.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-blit-copy.obj kernel32.lib
;
; Expected exit: 10
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
src BYTE 1,2,3,4

.data?
dst BYTE 4 DUP(?)

.code

ex_05_blit_copy PROC
lea rsi, src
    lea rdi, dst
    mov rcx, 4
    rep movsb
    xor rcx, rcx
    movzx rax, BYTE PTR [dst]
    add rcx, rax
    movzx rax, BYTE PTR [dst+1]
    add rcx, rax
    movzx rax, BYTE PTR [dst+2]
    add rcx, rax
    movzx rax, BYTE PTR [dst+3]
    add rcx, rax
    mov     eax, ecx
    ret
ex_05_blit_copy ENDP
main PROC
    sub     rsp, 40
    call    ex_05_blit_copy
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
