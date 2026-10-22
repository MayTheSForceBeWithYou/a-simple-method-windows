; Listing 22: Pratt binding powers: * binds tighter than +
; Expected exit: 14
; Expected stdout: (none)
;
; BP_MUL > BP_ADD, so 2 + 3 * 4 is evaluated as 2 + (3 * 4).

BP_ADD EQU 10
BP_MUL EQU 20

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     eax, BP_MUL
    cmp     eax, BP_ADD
    jle     wrong_order
    mov     rax, 3
    imul    rax, 4
    add     rax, 2
    mov     ecx, eax
    call    ExitProcess
wrong_order:
    mov     ecx, 20
    call    ExitProcess
main ENDP
END
