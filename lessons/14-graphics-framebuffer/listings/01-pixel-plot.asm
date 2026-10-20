; Listing 01: Framebuffer pixel plotting
;
; Purpose: Demonstrate direct framebuffer access concept.
; Expected exit code: 0
; Expected output: (none - would draw on screen)
;
; Note: Win32 graphics requires GDI or DirectX, different from Linux framebuffer.
; This shows the conceptual approach.
;
; Build: ml64 /c /Fo01-pixel-plot.obj 01-pixel-plot.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-pixel-plot.exe 01-pixel-plot.obj kernel32.lib

.DATA?
framebuffer DB 640 * 480 * 4 DUP(?) ; RGBA, 640x480

.CODE

EXTRN ExitProcess:PROC

; plot_pixel(x, y, color)
; RCX = x, RDX = y, R8 = color (RGBA)
plot_pixel PROC
    ; offset = (y * width + x) * 4
    mov rax, rdx               ; RAX = y
    imul rax, 640              ; RAX = y * width
    add rax, rcx               ; RAX = y * width + x
    shl rax, 2                 ; RAX *= 4 (bytes per pixel)
    
    lea r9, framebuffer
    mov DWORD PTR [r9+rax], r8d ; Store color
    ret
plot_pixel ENDP

main PROC
    sub rsp, 32
    
    ; Plot red pixel at (100, 100)
    mov rcx, 100               ; x
    mov rdx, 100               ; y
    mov r8d, 0xFF0000FFh       ; RGBA: red
    call plot_pixel
    
    xor ecx, ecx
    call ExitProcess
main ENDP

END
