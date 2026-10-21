; Listing 06: LEA vs MOV - computing addresses vs loading values
;
; Purpose: Show the crucial difference between LEA and MOV with memory operands.
; Expected exit code: 20
; Expected output: (none)
;
; Build: ml64 /c /Fo06-lea-vs-mov.obj 06-lea-vs-mov.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-lea-vs-mov.exe 06-lea-vs-mov.obj kernel32.lib

.DATA
value DQ 20

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; LEA: compute address, no memory access
    lea rax, value             ; RAX = address of value
    
    ; MOV: load value from memory
    mov rbx, value             ; RBX = 20 (loaded from memory)
    
    ; LEA with arithmetic: multiply by 3
    mov rcx, 5
    lea rdx, [rcx+rcx*2]       ; RDX = rcx + rcx*2 = 5 + 10 = 15
    
    ; Exit with the value (20)
    mov rcx, rbx
    call ExitProcess
main ENDP

END
