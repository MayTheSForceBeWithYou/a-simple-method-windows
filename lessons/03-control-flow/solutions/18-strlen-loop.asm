; Exercise 18: strlen loop
;
; Cstring 'hello',0. Count length 5 into rcx.
;
; Build: ml64 /c 18-strlen-loop.asm && link /OUT:18-strlen-loop.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-strlen-loop.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.data
s BYTE "hello", 0

.code
main PROC
    sub rsp, 40
    lea rsi, [s]
    xor rcx, rcx
loop_start:
    cmp BYTE PTR [rsi], 0
    je done
    inc rcx
    inc rsi
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
