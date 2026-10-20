; Listing 01: AABB collision detection
;
; Purpose: Detect if two axis-aligned bounding boxes overlap.
; Expected exit code: 1 (collision detected)
; Expected output: (none)
;
; Build: ml64 /c /Fo01-aabb-collision.obj 01-aabb-collision.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-aabb-collision.exe 01-aabb-collision.obj kernel32.lib

.DATA
; Box 1: x=10, y=10, w=20, h=20
box1 DQ 10, 10, 20, 20
; Box 2: x=15, y=15, w=20, h=20 (overlaps box1)
box2 DQ 15, 15, 20, 20

.CODE

EXTRN ExitProcess:PROC

; aabb_collide(box1, box2) -> 1 if collision, 0 if not
; RCX = pointer to box1 (x, y, w, h)
; RDX = pointer to box2
aabb_collide PROC
    ; Load box1: x1, y1, w1, h1
    mov r8, [rcx]              ; x1
    mov r9, [rcx+8]            ; y1
    mov r10, [rcx+16]          ; w1
    mov r11, [rcx+24]          ; h1
    
    ; Load box2: x2, y2, w2, h2
    mov rax, [rdx]             ; x2
    mov rbx, [rdx+8]           ; y2
    
    ; Check: x1 < x2+w2 && x2 < x1+w1
    mov rcx, rax
    add rcx, [rdx+16]          ; x2+w2
    cmp r8, rcx
    jge no_collision
    
    mov rcx, r8
    add rcx, r10               ; x1+w1
    cmp rax, rcx
    jge no_collision
    
    ; Check: y1 < y2+h2 && y2 < y1+h1
    mov rcx, rbx
    add rcx, [rdx+24]          ; y2+h2
    cmp r9, rcx
    jge no_collision
    
    mov rcx, r9
    add rcx, r11               ; y1+h1
    cmp rbx, rcx
    jge no_collision
    
    ; Collision detected
    mov rax, 1
    ret
    
no_collision:
    xor eax, eax
    ret
aabb_collide ENDP

main PROC
    sub rsp, 32
    
    lea rcx, box1
    lea rdx, box2
    call aabb_collide          ; RAX = 1 (collision)
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
