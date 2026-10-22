; Listing 04: Recursive sum_to (lines 70-94 of LESSON.md)
;
; Purpose: sum_to(n) = n + sum_to(n-1), base case 0.
; Expected exit: 15
; Expected stdout: (none)
;
; Build: ml64 /c /Fo04-recursive-sum.obj 04-recursive-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-recursive-sum.exe 04-recursive-sum.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; One push (8) + sub rsp,32 (32) => 40 bytes; RSP is 16-byte aligned at callee entry after `call`.
sum_to PROC FRAME
    push rbx
    .pushreg rbx
    sub rsp, 32
    .allocstack 32
    .endprolog
    mov rbx, rcx

    cmp rcx, 0
    jg recursive
    xor eax, eax
    jmp done

recursive:
    dec rcx
    call sum_to
    add rax, rbx
    jmp done

done:
    add rsp, 32
    pop rbx
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
