; Listing 09: SETcc family of instructions
;
; Purpose: Demonstrates various SETcc instructions.
; Expected exit code: 3 (three conditions true)
; Expected output: (none)
;
; Build: ml64 /c /Fo09-setcc-family.obj 09-setcc-family.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-setcc-family.exe 09-setcc-family.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    xor rax, rax               ; Counter = 0
    
    ; Test 1: equality
    mov rbx, 5
    cmp rbx, 5
    sete cl                    ; CL = 1 if equal
    movzx rcx, cl
    add rax, rcx               ; Count += 1
    
    ; Test 2: less than (signed)
    mov rbx, 3
    cmp rbx, 10
    setl cl                    ; CL = 1 if 3 < 10 (signed)
    movzx rcx, cl
    add rax, rcx               ; Count += 1
    
    ; Test 3: greater than (unsigned)
    mov rbx, 10
    cmp rbx, 5
    seta cl                    ; CL = 1 if 10 > 5 (unsigned)
    movzx rcx, cl
    add rax, rcx               ; Count += 1, total = 3
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
