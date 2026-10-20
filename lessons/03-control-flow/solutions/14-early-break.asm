; Exercise 14: early break
;
; Sum arr QWORD 5,5,5,5 until sum>=10; exit sum (10).
;
; Build: ml64 /c 14-early-break.asm && link /OUT:14-early-break.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-early-break.obj kernel32.lib
;
; Expected exit: 10

EXTERN ExitProcess:PROC

.data
arr QWORD 5, 5, 5, 5

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    xor r8, r8
loop_start:
    cmp rcx, 10
    jge done
    add rcx, QWORD PTR [arr+r8*8]
    inc r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
