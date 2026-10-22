; Exercise 19: debug offset bpp
; BUG: used *3 for RGBA8888. Fix *4; x=2 offset=8; exit 8.
; Expected exit: 8

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_offset_bpp:PROC

pixel_offset_bug PROC
    mov rcx, 2
    imul rcx, 3                 ; BUG: RGBA8888 needs *4
    mov rax, rcx
    ret
pixel_offset_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_offset_bpp in this file.
    call    ex_19_debug_offset_bpp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
