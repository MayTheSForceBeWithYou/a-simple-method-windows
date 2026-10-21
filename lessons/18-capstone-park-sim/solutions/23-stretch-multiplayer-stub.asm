; Exercise 23: stretch multiplayer stub
;
; STRETCH: net tick id 2; exit 2. (local stub)
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
tick_id QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [tick_id], 2
    mov rcx, QWORD PTR [tick_id]
    call ExitProcess
main ENDP
END
