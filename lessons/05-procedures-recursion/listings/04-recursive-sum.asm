; Listing 04: Recursive sum_to (lines 70-94 of LESSON.md)
;
; Purpose: sum_to(n) = n + sum_to(n-1), base case 0.
; Expected exit code: 15 (1+2+3+4+5)
; Expected output: (none)
;
; Build: ml64 /c /Fo04-recursive-sum.obj 04-recursive-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-recursive-sum.exe 04-recursive-sum.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_to PROC FRAME
    push rcx                   ; Save RCX (nonvolatile preservation)
    .pushreg rcx
    sub rsp, 32
    .allocstack 32
    .endprolog
    
    cmp rcx, 0
    jg recursive
    xor eax, eax               ; Base case: return 0
    jmp done
    
recursive:
    dec rcx
    call sum_to
    pop rcx                    ; Restore original n
    add rax, rcx               ; Add n to sum(n-1)
    ret
    
done:
    add rsp, 32
    pop rcx
    ret
sum_to ENDP

main PROC
    sub rsp, 32
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP

END
