; 20-weather-tick: weather tick
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_weather_tick:PROC
main PROC
    ; TODO: implement ex_20_weather_tick (student routine; defined in solutions/).
    call    ex_20_weather_tick
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
