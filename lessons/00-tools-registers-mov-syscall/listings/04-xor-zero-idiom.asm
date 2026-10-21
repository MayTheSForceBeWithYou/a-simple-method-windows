; Listing 04: The XOR-to-zero idiom
;
; Purpose: Demonstrates the idiomatic way to zero a register using XOR.
; Expected exit: 0
; Expected stdout: (none)
;
; Build: ml64 /c /Fo04-xor-zero-idiom.obj 04-xor-zero-idiom.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-xor-zero-idiom.exe 04-xor-zero-idiom.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32                ; Shadow space

    ; Two ways to zero a register:
    mov ecx, 0                 ; Explicit zero (works but longer encoding)
    
    ; Better: XOR idiom
    xor ecx, ecx               ; Shorter encoding, recognized by CPU
                               ; XOR of anything with itself = 0
                               ; Also zero-extends to 64 bits (ECX -> RCX)

    call ExitProcess           ; Exit with 0
main ENDP

END
