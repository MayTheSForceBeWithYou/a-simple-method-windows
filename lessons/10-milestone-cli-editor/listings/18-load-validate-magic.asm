; Listing 18: Load and validate magic (LESSON.md block 18)
;
; Purpose: Compare magic word; exit 1 on "ED" prefix match (drill semantics).
; Expected exit code: 1
; Expected stdout: (none)

.DATA
magic DB "ED01", 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    cmp     WORD PTR magic, 4445h
    jne     bad_magic
    mov     ecx, 1
    jmp     done
bad_magic:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP

END
