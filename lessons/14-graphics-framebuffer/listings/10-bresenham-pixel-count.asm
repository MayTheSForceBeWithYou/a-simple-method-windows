; Listing 10: Bresenham line from (0,0) to (3,2); count plotted points
; Expected exit: 4
; Expected stdout: (none)
;
; delta_x=3 delta_y=2; err starts at 2*delta_y-delta_x=1; plot each x in [0..3] (four columns).

.DATA?
x QWORD ?
y QWORD ?
delta_x QWORD ?
delta_y QWORD ?
err QWORD ?
count QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    push    rbx
    sub     rsp, 40
    mov     x, 0
    mov     y, 0
    mov     delta_x, 3
    mov     delta_y, 2
    mov     rax, delta_y
    shl     rax, 1
    sub     rax, delta_x
    mov     err, rax
    mov     count, 0

bres_loop:
    inc     count
    mov     rax, x
    cmp     rax, delta_x
    je      bres_done
    mov     rax, err
    mov     rbx, delta_y
    shl     rbx, 1
    add     rax, rbx
    mov     err, rax
    test    rax, rax
    jle     no_y_step
    inc     y
    mov     rbx, delta_x
    shl     rbx, 1
    sub     rax, rbx
    mov     err, rax
no_y_step:
    inc     x
    jmp     bres_loop

bres_done:
    add     rsp, 40
    pop     rbx
    sub     rsp, 40
    mov     rcx, count
    mov     ecx, ecx
    call    ExitProcess
main ENDP
END
