; Listing 10: Bresenham line from (0,0) to (3,2); count plotted points
; Expected exit: 4
; Expected stdout: (none)

.DATA?
x QWORD ?
y QWORD ?
x1 QWORD ?
y1 QWORD ?
dx QWORD ?
dy QWORD ?
sx QWORD ?
sy QWORD ?
err QWORD ?
count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     x, 0
    mov     y, 0
    mov     x1, 3
    mov     y1, 2
    mov     count, 0

    mov     rax, x1
    sub     rax, x
    jns     dx_pos
    neg     rax
    mov     sx, -1
    jmp     dx_done
dx_pos:
    mov     sx, 1
dx_done:
    mov     dx, rax

    mov     rax, y1
    sub     rax, y
    jns     dy_pos
    neg     rax
    mov     sy, -1
    jmp     dy_done
dy_pos:
    mov     sy, 1
dy_done:
    mov     dy, rax

    mov     rax, dx
    sub     rax, dy
    mov     err, rax

bres_loop:
    inc     count
    mov     rax, x
    cmp     rax, x1
    jne     bres_step
    mov     rax, y
    cmp     rax, y1
    je      bres_done

bres_step:
    mov     rax, err
    shl     rax, 1
    mov     rbx, dy
    neg     rbx
    cmp     rax, rbx
    jl      skip_x
    sub     err, dy
    add     x, sx
skip_x:
    mov     rax, err
    shl     rax, 1
    cmp     rax, dx
    jg      skip_y
    add     err, dx
    add     y, sy
skip_y:
    jmp     bres_loop

bres_done:
    mov     ecx, DWORD PTR count
    call    ExitProcess
main ENDP
END
