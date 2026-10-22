; Listing 06: Early loop exit with break
;
; Purpose: Demonstrate breaking out of loop early.
; Expected exit code: 3 (stops when counter == 3)
; Expected output: (none)
;
; Build: ml64 /c /Fo06-early-exit.obj 06-early-exit.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-early-exit.exe 06-early-exit.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rcx, rcx               ; Counter = 0
    
loop_start:
    inc rcx
    
    cmp rcx, 3
    je loop_done               ; Break when counter == 3
    
    cmp rcx, 10
    jl loop_start              ; Continue if counter < 10
    
loop_done:
    call ExitProcess
main ENDP

END
