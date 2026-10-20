; Listing 05: Signed vs unsigned comparison
;
; Purpose: Show different results for JL vs JB with same values.
; Expected exit code: 2 (both branches increment)
; Expected output: (none)
;
; Build: ml64 /c /Fo05-signed-vs-unsigned.obj 05-signed-vs-unsigned.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-signed-vs-unsigned.exe 05-signed-vs-unsigned.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rcx, rcx               ; Counter = 0
    
    ; Compare -1 with 1
    mov rax, -1                ; All bits set (signed: -1, unsigned: huge)
    mov rbx, 1
    
    ; Signed comparison: -1 < 1
    cmp rax, rbx
    jge not_less_signed
    inc rcx                    ; Count this
not_less_signed:
    
    ; Unsigned comparison: -1 (huge) > 1
    cmp rax, rbx
    jbe not_greater_unsigned
    inc rcx                    ; Count this
not_greater_unsigned:
    
    call ExitProcess
main ENDP

END
