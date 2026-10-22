; 20-weather-tick: weather tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_weather_tick:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_weather_tick in this file.
    call    ex_20_weather_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
