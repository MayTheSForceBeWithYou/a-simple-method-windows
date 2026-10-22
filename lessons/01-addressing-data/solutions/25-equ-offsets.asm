; Exercise 25: equ offsets
;
; Use EQU for OFF_B EQU 8. vals QWORD 3,9. Load [vals+OFF_B] exit 9.
;
; Build: ml64 /c 25-equ-offsets.asm && link /OUT:25-equ-offsets.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-equ-offsets.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

OFF_B EQU 8

.data
vals QWORD 3, 9

.code
ex_25_equ_offsets PROC
    sub rsp, 40
    mov rcx, QWORD PTR [vals+OFF_B]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_25_equ_offsets ENDP
main PROC
    sub     rsp, 40
    call    ex_25_equ_offsets
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
