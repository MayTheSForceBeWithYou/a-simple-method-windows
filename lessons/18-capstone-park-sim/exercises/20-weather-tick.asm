; Exercise: 20-weather-tick
;
; Exercise 20: weather tick
; Rain intensity 0..3 cycle; from 3 -> 0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_20_weather_tick` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

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
