; Exercise 11: max in array
;
; arr QWORD 3,9,2,7. Max in rcx (9).
;
; Build: ml64 /c 11-max-in-array.asm && link /OUT:11-max-in-array.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-max-in-array.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

.data
arr QWORD 3, 9, 2, 7
n EQU 4

.code
ex_11_max_in_array PROC
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
    jle cont
    mov rcx, rax
cont:
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_max_in_array ENDP
main PROC
    sub     rsp, 40
    call    ex_11_max_in_array
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
