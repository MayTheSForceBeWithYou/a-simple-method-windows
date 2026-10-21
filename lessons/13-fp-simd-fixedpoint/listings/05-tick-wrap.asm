; Listing 05: Counter wrap after threshold (LESSON.md block 5)
; Expected exit: 10
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     eax, 350
    add     eax, 20
    cmp     eax, 360
    jl      done
    sub     eax, 360
done:
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
