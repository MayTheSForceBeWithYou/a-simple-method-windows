; Exercise 08: find first
;
; arr BYTE 3,1,4,1,5. Find first index of 4 (2). Exit index.
;
; Build: ml64 /c 08-find-first.asm && link /OUT:08-find-first.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-find-first.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
arr BYTE 3, 1, 4, 1, 5
n EQU 5

.code
main PROC
    sub rsp, 40
    xor r8, r8
loop_start:
    cmp r8, n
    jge missing
    lea r11, [arr]
    movzx rax, BYTE PTR [r11+r8]
    cmp rax, 4
    je found
    inc r8
    jmp loop_start
found:
    mov rcx, r8
    jmp exit_proc
missing:
    mov rcx, 255
exit_proc:
    call ExitProcess
main ENDP
END
