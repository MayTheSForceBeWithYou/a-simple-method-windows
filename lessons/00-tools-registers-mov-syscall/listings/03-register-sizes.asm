; Listing 03: Register size variants and zero-extension
;
; Purpose: Demonstrates how writing to 32-bit register names zero-extends to 64 bits,
;          while writing to 8-bit or 16-bit names leaves upper bits unchanged.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo03-register-sizes.obj 03-register-sizes.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-register-sizes.exe 03-register-sizes.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32                ; Shadow space

    ; Demonstrate zero-extension with 32-bit write
    mov rax, -1                ; Fill RAX with all 1s (0xFFFFFFFFFFFFFFFF)
    mov eax, 42                ; Write to EAX zeros upper 32 bits
                               ; RAX is now 0x000000000000002A (42)

    ; Demonstrate partial update with 8-bit write
    mov rax, -1                ; Fill RAX with all 1s again
    mov al, 42                 ; Write to AL leaves upper 56 bits unchanged
                               ; RAX is now 0xFFFFFFFFFFFFFF2A

    ; Exit with 42 (using zero-extending 32-bit write)
    mov ecx, 42                ; Zero-extends to RCX
    call ExitProcess
main ENDP

END
