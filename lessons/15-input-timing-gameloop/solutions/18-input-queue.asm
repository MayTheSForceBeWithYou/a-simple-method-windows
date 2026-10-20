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
main PROC
    sub rsp, 32
    mov rcx, [t]
    mov QWORD PTR [q+rcx*8], 9
    inc QWORD PTR [t]
    mov rcx, [h]
    mov rcx, [q+rcx*8]
    inc QWORD PTR [h]
    call ExitProcess
main ENDP
END
