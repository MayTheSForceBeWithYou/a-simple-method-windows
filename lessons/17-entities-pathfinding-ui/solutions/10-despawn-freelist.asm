; Exercise 10: despawn freelist
;
; Free id 3 onto freelist top; exit 3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
free_top QWORD 0

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [free_top], 3
    mov rcx, QWORD PTR [free_top]
    call ExitProcess
main ENDP
END
