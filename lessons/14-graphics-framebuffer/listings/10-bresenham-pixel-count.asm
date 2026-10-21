; Listing 10: Bresenham line from (0,0) to (3,2); count plotted points
; Expected exit: 4
; Expected stdout: (none)
;
; dx=3 dy=2; err starts at 2*dy-dx=1; plot each x in [0..3] (four columns).

.DATA?
x QWORD ?
y QWORD ?
dx QWORD ?
dy QWORD ?
err QWORD ?
count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 32
    mov     x, 0
    mov     y, 0
    mov     dx, 3
    mov     dy, 2
    mov     rax, dy
    shl     rax, 1
    sub     rax, dx
    mov     err, rax
    mov     count, 0

bres_loop:
    inc     count
    cmp     x, dx
    je      bres_done
    mov     rax, err
    mov     rbx, dy
    shl     rbx, 1
    add     rax, rbx
    mov     err, rax
    test    rax, rax
    jle     no_y_step
    inc     y
    mov     rbx, dx
    shl     rbx, 1
    sub     rax, rbx
    mov     err, rax
no_y_step:
    inc     x
    jmp     bres_loop

bres_done:
    mov     ecx, DWORD PTR count
    call    ExitProcess
main ENDP
END
