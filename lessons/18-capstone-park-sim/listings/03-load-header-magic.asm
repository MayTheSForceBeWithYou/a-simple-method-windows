; Listing 03: Validate save header magic/version (LESSON.md block 3)
; Expected exit: 1
; Expected stdout: (none)

.DATA
header_buf DB "PK01", 1, 0, 0, 0

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    ; LE DWORD for ASCII PK01: 31h,30h,4Bh,50h -> 31304B50h (not ZIP 02014B50h)
    cmp     DWORD PTR header_buf, 31304B50h
    jne     bad
    cmp     DWORD PTR header_buf[4], 1
    jne     bad
    mov     ecx, 1
    jmp     done
bad:
    xor     ecx, ecx
done:
    call    ExitProcess
main ENDP
END
