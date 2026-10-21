; Listing 01: AABB overlap test
; Expected exit: 1
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     r8, 10
    mov     r9, 20
    mov     r10, 15
    mov     r11, 25
    cmp     r10, r8
    jl      no_collide
    cmp     r11, r9
    jl      no_collide
    mov     ecx, 1
    jmp     done
no_collide:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP

END
