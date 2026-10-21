; Listing 01: Bitwise operations
;
; Purpose: Demonstrate AND, OR, XOR, NOT, SHL, SHR.
; Expected exit code: 12
; Expected output: (none)
;
; Build: ml64 /c /Fo01-bit-operations.obj 01-bit-operations.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-bit-operations.exe 01-bit-operations.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; AND: clear bits
    mov rax, 0xFF              ; 11111111
    and rax, 0x0F              ; 00001111 -> RAX = 15
    
    ; OR: set bits
    mov rbx, 0x08              ; 00001000
    or rbx, 0x04               ; 00000100 -> RBX = 12
    
    ; XOR: toggle bits
    mov rcx, 0xFF
    xor rcx, 0xFF              ; RCX = 0
    
    ; NOT: invert all bits
    mov rdx, 0
    not rdx                    ; RDX = -1 (all 1s)
    
    ; SHL: shift left (multiply by 2)
    mov r8, 3
    shl r8, 2                  ; R8 = 12 (3 * 4)
    
    ; SHR: shift right (unsigned divide by 2)
    mov r9, 48
    shr r9, 2                  ; R9 = 12 (48 / 4)
    
    mov rcx, rbx               ; Exit with 12
    call ExitProcess
main ENDP

END
