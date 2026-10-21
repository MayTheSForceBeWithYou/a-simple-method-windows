; Exercise 09: pointer walk
;
; bytes BYTE 1,2,3,4. rsi=&bytes. Sum four byte loads with inc rsi into rcx, exit (10).
;
; Build: ml64 /c 09-pointer-walk.asm && link /OUT:09-pointer-walk.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-pointer-walk.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
bytes BYTE 1, 2, 3, 4

.code
main PROC
    sub rsp, 40
    lea rsi, [bytes]
    xor rcx, rcx
    movzx rax, BYTE PTR [rsi]
    add rcx, rax
    inc rsi
    movzx rax, BYTE PTR [rsi]
    add rcx, rax
    inc rsi
    movzx rax, BYTE PTR [rsi]
    add rcx, rax
    inc rsi
    movzx rax, BYTE PTR [rsi]
    add rcx, rax
    call ExitProcess
main ENDP
END
