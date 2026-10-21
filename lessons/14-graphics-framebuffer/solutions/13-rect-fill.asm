; Exercise 13: rect fill
;
; Fill 2x2 rect with 3; sum=12.
;
; Build: ml64 /c 13-rect-fill.asm && link /OUT:13-rect-fill.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-rect-fill.obj kernel32.lib
;
; Expected exit: 12
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 16 DUP(?)

.code
main PROC
    sub rsp, 40
    mov BYTE PTR [fb], 3
    mov BYTE PTR [fb+1], 3
    mov BYTE PTR [fb+4], 3
    mov BYTE PTR [fb+5], 3
    xor rcx, rcx
    movzx rax, BYTE PTR [fb]
    add rcx, rax
    movzx rax, BYTE PTR [fb+1]
    add rcx, rax
    movzx rax, BYTE PTR [fb+4]
    add rcx, rax
    movzx rax, BYTE PTR [fb+5]
    add rcx, rax
    call ExitProcess
main ENDP
END
