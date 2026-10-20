; Listing 01: Recursive factorial
;
; Purpose: Demonstrate recursion with proper stack management.
; Expected exit code: 120 (5!)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-factorial.obj 01-factorial.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-factorial.exe 01-factorial.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; factorial(n): returns n!
; Base case: n <= 1 returns 1
; Recursive: n * factorial(n-1)
factorial PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    cmp rcx, 1
    jg recursive
    mov rax, 1                 ; Base case: return 1
    jmp done
    
recursive:
    mov rbx, rcx               ; Save n
    dec rcx                    ; n-1
    call factorial             ; factorial(n-1) in RAX
    imul rax, rbx              ; n * factorial(n-1)
    
done:
    add rsp, 32
    pop rbx
    ret
factorial ENDP

main PROC
    sub rsp, 32
    
    mov rcx, 5
    call factorial             ; 5! = 120
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
