; Exercise: 17-closure-sim
;
; Exercise 17: closure sim
; Context in r12 (nonvolatile). add_ctx(5)=5+10=15.
;
; Contract: implement `ex_17_closure_sim` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;

; Exercise 17: 17-closure-sim.asm (Win32 port)
; Pass context pointer in r12 (callee-saved): ctx dq 10; add_ctx(rdi) returns rdi+[ctx]. Call with 5 -> 15.
; Build: ml64 /c /Fo17-closure-sim.asm.obj 17-closure-sim.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-closure-sim.asm.exe 17-closure-sim.asm.obj kernel32.lib
; Expected: see original exercise

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_closure_sim:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_closure_sim in this file.
    call    ex_17_closure_sim
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
