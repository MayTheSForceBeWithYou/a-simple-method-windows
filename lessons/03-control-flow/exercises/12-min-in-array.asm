; Exercise: 12-min-in-array
;
; Exercise 12: min in array
; Same array; min 2.
;
; Contract: implement `ex_12_min_in_array` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 12: min in array
;
; Same array; min 2.
;
; Build: ml64 /c 12-min-in-array.asm && link /OUT:12-min-in-array.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-min-in-array.obj kernel32.lib
;
; Expected exit: 2


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_min_in_array:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_min_in_array in this file.
    call    ex_12_min_in_array
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
