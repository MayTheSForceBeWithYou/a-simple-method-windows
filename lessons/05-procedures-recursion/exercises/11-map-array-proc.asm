; Exercise: 11-map-array-proc
;
; Exercise 11: map array proc
; apply_inc: for {1,2,3,4}, +=1 each. Sum=2+3+4+5=14.
;
; Contract: implement `ex_11_map_array_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 14
;

; Exercise 11: 11-map-array-proc.asm (Win32 port)
; apply_inc: for each of 4 qwords, +=1 via procedure. Sum after = 14 for {1,2,3,4}->15? 2+3+4+5=14. Exit 14.
; Build: ml64 /c /Fo11-map-array-proc.asm.obj 11-map-array-proc.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-map-array-proc.asm.exe 11-map-array-proc.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_map_array_proc:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_11_map_array_proc in this file.
    call    ex_11_map_array_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
