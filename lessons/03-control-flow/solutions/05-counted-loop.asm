; Exercise 05: counted loop
;
; Add r8 times: start rcx=0,r8=5; loop add 3 each time; exit 15.
;
; Build: ml64 /c 05-counted-loop.asm && link /OUT:05-counted-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 05-counted-loop.obj kernel32.lib
;
; Expected exit: 15

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    mov r8, 5
loop_start:
    cmp r8, 0
    je done
    add rcx, 3
    dec r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
