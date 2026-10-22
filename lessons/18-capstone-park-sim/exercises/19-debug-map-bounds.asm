; Exercise 19: debug map bounds
; BUG: no bounds check. Clamp x=99 to w-1=7; exit 7.
; Expected exit: 7

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_map_bounds:PROC

map_bounds_bug PROC
    mov rax, 99                 ; BUG: no clamp to width-1
    ret
map_bounds_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_map_bounds in this file.
    call    ex_19_debug_map_bounds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
