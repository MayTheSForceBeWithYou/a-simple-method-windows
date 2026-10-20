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
main PROC
    sub rsp, 32
    mov rcx, [arr]
    mov r8, 1
loop_start:
    cmp r8, n
    jge done
    mov rax, QWORD PTR [arr+r8*8]
    cmp rax, rcx
    jge cont
    mov rcx, rax
cont:
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
