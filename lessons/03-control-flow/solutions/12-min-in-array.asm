; Exercise 12: min in array
;
; Same array; min 2.
;
; Build: ml64 /c 12-min-in-array.asm && link /OUT:12-min-in-array.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-min-in-array.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

.data
arr QWORD 3, 9, 2, 7
n EQU 4

.code
ex_12_min_in_array PROC
    sub rsp, 40
    lea r11, [arr]
    mov rcx, QWORD PTR [r11]
    mov r8, 1
loop_start:
    cmp r8, n
    jge done
    lea r11, [arr]
    mov rax, QWORD PTR [r11+r8*8]
    cmp rax, rcx
    jge cont
    mov rcx, rax
cont:
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_min_in_array ENDP
main PROC
    sub     rsp, 40
    call    ex_12_min_in_array
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
