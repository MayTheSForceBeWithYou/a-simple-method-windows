; Listing 22: Pratt binding powers (+ looser than *)
; Expected exit: 20
; Expected stdout: (none)

BP_ADD EQU 10
BP_MUL EQU 20

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     ecx, BP_MUL
    call    ExitProcess
main ENDP
END
