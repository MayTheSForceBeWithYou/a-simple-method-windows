; Listing 03: Register-indirect addressing
;
; Purpose: Access memory through pointer registers.
; Expected exit code: 72 (ASCII 'H')
; Expected output: (none)
;
; Build: ml64 /c /Fo03-register-indirect.obj 03-register-indirect.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-register-indirect.exe 03-register-indirect.obj kernel32.lib

.DATA
msg DB "Hello", 0

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Load address of msg into RSI
    lea rsi, msg
    
    ; Load first byte through register-indirect addressing
    movzx rcx, BYTE PTR [rsi]  ; RCX = 'H' (72)
    
    call ExitProcess
main ENDP

END
