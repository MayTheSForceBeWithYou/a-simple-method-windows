; Exercise 25: stretch binsearch
;
; STRETCH: sorted QWORD 1,3,5,7,9. Binary search for 7; exit index 3.
;
; Build: ml64 /c 25-stretch-binsearch.asm && link /OUT:25-stretch-binsearch.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-stretch-binsearch.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data
arr QWORD 1, 3, 5, 7, 9
n EQU 5

.code
main PROC
    sub rsp, 32
    xor r8, r8
    mov r9, n
    dec r9
    mov r10, 7
loop_start:
    cmp r8, r9
    jg miss
    mov rax, r8
    add rax, r9
    shr rax, 1
    mov rcx, rax
    mov rdx, QWORD PTR [arr+rcx*8]
    cmp rdx, r10
    je found
    jl go_right
    mov r9, rcx
    dec r9
    jmp loop_start
go_right:
    mov r8, rcx
    inc r8
    jmp loop_start
found:
    mov rcx, r8
    jmp out
miss:
    mov rcx, 255
out:
    call ExitProcess
main ENDP
END
