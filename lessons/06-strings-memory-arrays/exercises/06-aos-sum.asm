; Exercise: 06-aos-sum
;
; Exercise 06: aos sum
; AoS records {x,y}. Two ents (1,2), (3,4). Sum all=10.
;
; Contract: implement `ex_06_aos_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;

; Exercise 06: 06-aos-sum (Win32 port)
; AoS records {dq x,y} two ents. Sum all coords exit.
; Build: ml64 /c /Fo06-aos-sum.obj 06-aos-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-aos-sum.exe 06-aos-sum.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_06_aos_sum:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_06_aos_sum in this file.
    call    ex_06_aos_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
