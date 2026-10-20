; Listing 01: Basic game loop structure
;
; Purpose: Demonstrate game loop with timing (concept).
; Expected exit code: 0
; Expected output: (none - would run game loop)
;
; Note: Uses QueryPerformanceCounter for timing on Windows.
;
; Build: ml64 /c /Fo01-game-loop.obj 01-game-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-game-loop.exe 01-game-loop.obj kernel32.lib

.DATA
running DB 1
frame_count DQ 0

.DATA?
counter DQ ?
frequency DQ ?

.CODE

EXTRN QueryPerformanceCounter:PROC
EXTRN QueryPerformanceFrequency:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    ; Get timer frequency
    lea rcx, frequency
    call QueryPerformanceFrequency
    
    ; Game loop (limited to 10 frames for demo)
game_loop:
    cmp frame_count, 10
    jge loop_done
    
    ; Update game state
    inc frame_count
    
    ; Render (stub)
    
    ; Check input (stub)
    
    jmp game_loop
    
loop_done:
    xor ecx, ecx
    call ExitProcess
main ENDP

END
