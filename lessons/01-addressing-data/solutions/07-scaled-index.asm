; Exercise 07: scaled index
;
; arr QWORD 5,10,15,20. Set r8=2, load arr[r8] with [arr+r8*8] into rcx, exit (15).
;
; Build: ml64 /c 07-scaled-index.asm && link /OUT:07-scaled-index.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-scaled-index.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.data
arr QWORD 5, 10, 15, 20

.code

ex_07_scaled_index PROC
mov r8, 2
    lea r11, [arr]
    mov rcx, QWORD PTR [r11+r8*8]
    mov     eax, ecx
    ret
ex_07_scaled_index ENDP
main PROC
    sub     rsp, 40
    call    ex_07_scaled_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
