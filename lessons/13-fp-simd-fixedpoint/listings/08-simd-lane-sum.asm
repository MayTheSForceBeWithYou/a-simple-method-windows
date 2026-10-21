; Listing 08: Scalar lane sum (SIMD-style 4-byte vector)
; Expected exit: 10
; Expected stdout: (none)

.DATA
v BYTE 1, 2, 3, 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     ecx, ecx
    movzx   eax, BYTE PTR v[0]
    add     ecx, eax
    movzx   eax, BYTE PTR v[1]
    add     ecx, eax
    movzx   eax, BYTE PTR v[2]
    add     ecx, eax
    movzx   eax, BYTE PTR v[3]
    add     ecx, eax
    call    ExitProcess
main ENDP
END
