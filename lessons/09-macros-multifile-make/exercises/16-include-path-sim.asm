; Exercise: 16-include-path-sim
;
; Exercise 16: include path sim
; Define VERSION 3; exit VERSION.
;
; Contract: implement `ex_16_include_path_sim` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; 16-include-path-sim.asm
; Define VERSION = 3, exit 3.

; TODO: VERSION EQU 3

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_include_path_sim:PROC

main PROC
    sub     rsp, 40
    ; TODO: VERSION EQU 3 and return 3 from ex_16_include_path_sim.
    call    ex_16_include_path_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
