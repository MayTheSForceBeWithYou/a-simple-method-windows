; Exercise 06: sum 1 n
;
; Sum 1..n for n=10 into rcx (55).
;
; Build: ml64 /c 06-sum-1-n.asm && link /OUT:06-sum-1-n.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-sum-1-n.obj kernel32.lib
;
; Expected exit: 55

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 1
loop_start:
    cmp r8, 10
    jg done
    add rcx, r8
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
