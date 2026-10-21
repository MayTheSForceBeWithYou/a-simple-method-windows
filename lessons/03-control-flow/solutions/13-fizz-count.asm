; Exercise 13: fizz count
;
; AoC-lite: count numbers 1..20 divisible by 3 (6). Exit 6.
;
; Build: ml64 /c 13-fizz-count.asm && link /OUT:13-fizz-count.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-fizz-count.obj kernel32.lib
;
; Expected exit: 6

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 1
loop_start:
    cmp r8, 20
    jg done
    mov rax, r8
    xor rdx, rdx
    mov rbx, 3
    div rbx
    cmp rdx, 0
    jne next
    inc rcx
next:
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
