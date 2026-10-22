; Exercise: 25-equ-offsets
;
; Exercise 25: equ offsets
; Use EQU for OFF_B EQU 8. vals QWORD 3,9. Load [vals+OFF_B] exit 9.
;
; Contract: implement `ex_25_equ_offsets` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; Exercise 25: equ offsets
;
; Use EQU for OFF_B EQU 8. vals QWORD 3,9. Load [vals+OFF_B] exit 9.
;
; Build: ml64 /c 25-equ-offsets.asm && link /OUT:25-equ-offsets.exe /ENTRY:main /SUBSYSTEM:CONSOLE 25-equ-offsets.obj kernel32.lib
;
; Expected exit: 9


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_25_equ_offsets:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_25_equ_offsets in this file.
    call    ex_25_equ_offsets
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
