; Exercise: 20-weather-tick
;
; Rain intensity 0..3 cycle; from 3 -> 0; exit 0.
; Expected stdout: (none)
; Expected exit: 0
;
.data
rain QWORD 0

.code
ex_20_weather_tick PROC
    sub rsp, 40
    mov QWORD PTR [rain], 3
    inc QWORD PTR [rain]
    and QWORD PTR [rain], 3
    mov rcx, QWORD PTR [rain]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_20_weather_tick ENDP
main PROC
    sub     rsp, 40
    call    ex_20_weather_tick
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
