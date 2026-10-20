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
main PROC
    sub rsp, 32
    mov rcx, [arr]
    mov r8, 1
loop_start:
    cmp r8, n
    jge done
    mov rax, QWORD PTR [arr+r8*8]
    cmp rax, rcx
    jle cont
    mov rcx, rax
cont:
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
