; Exercise: 09-count-evens
;
; Exercise 09: count evens
; arr BYTE 1,2,3,4,5,6. Count evens (3). test rax,1 / jz.
;
; Contract: implement `ex_09_count_evens` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; Exercise 09: count evens
;
; arr BYTE 1,2,3,4,5,6. Count evens (3). test rax,1 / jz.
;
; Build: ml64 /c 09-count-evens.asm && link /OUT:09-count-evens.exe /ENTRY:main /SUBSYSTEM:CONSOLE 09-count-evens.obj kernel32.lib
;
; Expected exit: 3


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_count_evens:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_count_evens in this file.
    call    ex_09_count_evens
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
