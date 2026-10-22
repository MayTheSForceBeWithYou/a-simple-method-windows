; Exercise 09: count evens
;
; arr BYTE 1,2,3,4,5,6. Count evens (3). test rax,1 / jz.
;
; Build: ml64 /c 09-count-evens.asm && link /OUT:09-count-evens.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-count-evens.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
arr BYTE 1, 2, 3, 4, 5, 6
n EQU 6

.code
ex_09_count_evens PROC
    sub rsp, 40
    xor rcx, rcx
    xor r8, r8
loop_start:
    cmp r8, n
    jge done
    lea r11, [arr]
    movzx rax, BYTE PTR [r11+r8]
    test rax, 1
    jnz odd
    inc rcx
odd:
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_09_count_evens ENDP
main PROC
    sub     rsp, 40
    call    ex_09_count_evens
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
