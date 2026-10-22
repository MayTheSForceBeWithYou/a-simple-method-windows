; Exercise: 11-max-in-array
;
; Exercise 11: max in array
; arr QWORD 3,9,2,7. Max in rcx (9).
;
; Contract: implement `ex_11_max_in_array` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; Exercise 11: max in array
;
; arr QWORD 3,9,2,7. Max in rcx (9).
;
; Build: ml64 /c 11-max-in-array.asm && link /OUT:11-max-in-array.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-max-in-array.obj kernel32.lib
;
; Expected exit: 9


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_max_in_array:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_max_in_array in this file.
    call    ex_11_max_in_array
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
