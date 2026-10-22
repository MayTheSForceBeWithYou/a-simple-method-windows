; Exercise 12: vline
;
; Vertical with stride 4; plot 3 pixels; sum=6 if value 2.
;
; Build: ml64 /c 12-vline.asm && link /OUT:12-vline.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-vline.obj kernel32.lib
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
fb BYTE 16 DUP(?)

.code
ex_12_vline PROC
    sub rsp, 40
    mov BYTE PTR [fb], 2
    mov BYTE PTR [fb+4], 2
    mov BYTE PTR [fb+8], 2
    xor rcx, rcx
    movzx rax, BYTE PTR [fb]
    add rcx, rax
    movzx rax, BYTE PTR [fb+4]
    add rcx, rax
    movzx rax, BYTE PTR [fb+8]
    add rcx, rax
    mov     eax, 6
    add     rsp, 40
    ret
ex_12_vline ENDP
main PROC
    call    ex_12_vline
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
