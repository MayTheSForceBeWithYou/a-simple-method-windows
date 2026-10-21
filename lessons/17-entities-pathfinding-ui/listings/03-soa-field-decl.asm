; Listing 03: Structure-of-arrays field declarations (LESSON.md block 3)
; Expected exit: 0
; Expected stdout: (none)

.DATA
xs DQ 0, 5, 0
ys DQ 0, 6, 0
vxs DQ 1, 2, 3
alive DB 1, 0, 1

.CODE
EXTRN ExitProcess:PROC

main PROC
    xor     ecx, ecx
    call    ExitProcess
main ENDP
END
