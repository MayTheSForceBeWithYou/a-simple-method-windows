; Listing 03: While loop
;
; Purpose: Demonstrate while loop summing numbers.
; Expected exit code: 15 (1+2+3+4+5)
; Expected output: (none)
;
; Build: ml64 /c /Fo03-while-loop.obj 03-while-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-while-loop.exe 03-while-loop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; Sum = 0
    mov rcx, 5                 ; Counter = 5
    
loop_start:
    cmp rcx, 0
    jle loop_done              ; While rcx > 0
    
    add rax, rcx               ; sum += counter
    dec rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
