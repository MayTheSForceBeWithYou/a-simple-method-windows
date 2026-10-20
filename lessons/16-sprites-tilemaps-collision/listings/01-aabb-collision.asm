; AABB collision test, exit 1 if collide else 0
.CODE
EXTRN ExitProcess:PROC
main PROC
    mov r8, 10
    mov r9, 20
    mov r10, 15
    mov r11, 25
    cmp r10, r8
    jl no_collide
    cmp r11, r9
    jl no_collide
    mov ecx, 1
    jmp done
no_collide:
    xor ecx, ecx
done:
    call ExitProcess
main ENDP
END
