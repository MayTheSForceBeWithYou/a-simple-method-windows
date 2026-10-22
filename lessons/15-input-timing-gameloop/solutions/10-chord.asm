; Exercise 10: chord
;
; W and Shift both down -> run=1; exit 1.
;
; Build: ml64 /c 10-chord.asm && link /OUT:10-chord.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-chord.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
w BYTE ?
shift BYTE ?

.code
ex_10_chord PROC
    sub rsp, 40
    mov BYTE PTR [w], 1
    mov BYTE PTR [shift], 1
    movzx eax, BYTE PTR [w]
    and al, BYTE PTR [shift]
    movzx rcx, al
    mov     eax, 1
    ret
    add     rsp, 40
ex_10_chord ENDP
main PROC
    call    ex_10_chord
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
