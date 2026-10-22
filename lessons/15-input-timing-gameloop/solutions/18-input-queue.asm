; Exercise 18: input queue
;
; Enqueue event 9; dequeue; exit 9.
;
; Build: ml64 /c 18-input-queue.asm && link /OUT:18-input-queue.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-input-queue.obj kernel32.lib
;
; Expected exit: 9
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
q QWORD 4 DUP(?)
h QWORD ?
t QWORD ?

.code

ex_18_input_queue PROC
mov rcx, [t]
    lea r11, [q]
    mov QWORD PTR [r11+rcx*8], 9
    inc QWORD PTR [t]
    mov rcx, [h]
    lea r11, [q]
    mov rcx, [r11+rcx*8]
    inc QWORD PTR [h]
    mov     eax, ecx
    ret
ex_18_input_queue ENDP
main PROC
    sub     rsp, 40
    call    ex_18_input_queue
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
