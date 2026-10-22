; Exercise: 23-stretch-memo-fib-slot
;
; Exercise 23: stretch memo fib slot
; Memoized fib(8)=21. Exit 21.
;
; Contract: implement `ex_23_stretch_memo_fib_slot` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 21
;

; Exercise 23: 23-stretch-memo-fib-slot.asm (Win32 port)
; STRETCH: memo[10] slots; fib with memo fill. fib(8)=21; exit 21.
; Build: ml64 /c /Fo23-stretch-memo-fib-slot.asm.obj 23-stretch-memo-fib-slot.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:23-stretch-memo-fib-slot.asm.exe 23-stretch-memo-fib-slot.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_memo_fib_slot:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_23_stretch_memo_fib_slot in this file.
    call    ex_23_stretch_memo_fib_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
