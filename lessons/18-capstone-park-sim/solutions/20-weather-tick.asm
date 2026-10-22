; Exercise 20: weather tick
;
; Rain intensity 0..3 cycle; from 3 -> 0; exit 0.
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
rain QWORD 0

.code
ex_20_weather_tick PROC
    sub rsp, 40
    mov QWORD PTR [rain], 3
    inc QWORD PTR [rain]
    and QWORD PTR [rain], 3
        mov     eax, QWORD PTR [rain]
    ret

ex_20_weather_tick ENDP
main PROC
    call    ex_20_weather_tick
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
