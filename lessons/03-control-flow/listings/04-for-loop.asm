; Listing 04: For loop (counted iteration)
;
; Purpose: Demonstrate for-style loop from 0 to N-1.
; Expected exit code: 10 (sum of 0+1+2+3+4)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-for-loop.obj 04-for-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-for-loop.exe 04-for-loop.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax               ; Sum = 0
    xor rcx, rcx               ; Index = 0
    mov r8, 5                  ; Limit = 5
    
loop_start:
    cmp rcx, r8
    jge loop_done              ; While index < limit
    
    add rax, rcx               ; sum += index
    inc rcx
    jmp loop_start
    
loop_done:
    mov rcx, rax
    call ExitProcess
main ENDP

END
