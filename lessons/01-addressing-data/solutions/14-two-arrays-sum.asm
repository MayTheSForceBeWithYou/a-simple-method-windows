; Exercise 14: two arrays sum
;
; a QWORD 3,4  b QWORD 5,6. rcx = a[0]+a[1]+b[0]+b[1] (18), exit.
;
; Build: ml64 /c 14-two-arrays-sum.asm && link /OUT:14-two-arrays-sum.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-two-arrays-sum.obj kernel32.lib
;
; Expected exit: 18

EXTERN ExitProcess:PROC

.data
a QWORD 3, 4
b QWORD 5, 6

.code
ex_14_two_arrays_sum PROC
    sub rsp, 40
    mov rcx, [a]
    add rcx, [a+8]
    add rcx, [b]
    add rcx, [b+8]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_14_two_arrays_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_14_two_arrays_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
