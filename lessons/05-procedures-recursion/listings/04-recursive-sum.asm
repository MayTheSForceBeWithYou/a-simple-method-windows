; Listing 04: Recursive sum_to (lines 70-94 of LESSON.md)
;
; Purpose: sum_to(n) = n + sum_to(n-1), base case 0.
; Expected exit: 15
; Expected stdout: (none)
;
; Build: ml64 /c /Fo04-recursive-sum.obj 04-recursive-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-recursive-sum.exe 04-recursive-sum.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

sum_to PROC FRAME
    push rcx                   ; Save n on stack across recursive call (rcx is volatile)
    .pushreg rcx
    sub rsp, 40
    .allocstack 40
    .endprolog
    
    cmp rcx, 0
    jg recursive
    xor eax, eax               ; Base case: return 0
    jmp done
    
recursive:
    dec rcx
    call sum_to
    add rax, [rsp+40]          ; Add saved n (still on stack below shadow)
    jmp done
    
done:
    add rsp, 40
    pop rcx
    ret
sum_to ENDP

main PROC
    sub rsp, 40
    mov rcx, 5
    call sum_to
    mov rcx, rax
    call ExitProcess
main ENDP

END
