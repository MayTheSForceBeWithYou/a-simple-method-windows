; Exercise 21: loop mul table
;
; Compute 7*8 via repeated addition loop. Exit 56.
;
; Build: ml64 /c 21-loop-mul-table.asm && link /OUT:21-loop-mul-table.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-loop-mul-table.obj kernel32.lib
;
; Expected exit: 56

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    xor rcx, rcx
    mov r8, 8
loop_start:
    cmp r8, 0
    je done
    add rcx, 7
    dec r8
    jmp loop_start
done:
    call ExitProcess
main ENDP
END
