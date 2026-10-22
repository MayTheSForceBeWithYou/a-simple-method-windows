; Listing 10: Clip partially visible sprite width (LESSON.md)
;
; Purpose: sx=6, sw=8, view_w=10 — right edge clips to sw=4.
; Expected exit: 4
; Expected stdout: (none)
;
; Build: ml64 /c /Fo10-sprite-clip-margin.obj 10-sprite-clip-margin.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-sprite-clip-margin.exe 10-sprite-clip-margin.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 40

    mov     eax, 6              ; sx
    mov     ebx, 8              ; sw
    mov     ecx, 10             ; view_w

    cmp     eax, 0
    jge     skip_left
    add     ebx, eax            ; sw += sx (sx negative)
    xor     eax, eax
skip_left:
    mov     edx, eax
    add     edx, ebx
    cmp     edx, ecx
    jle     have_width
    mov     ebx, ecx
    sub     ebx, eax            ; sw = view_w - sx
have_width:
    cmp     ebx, 0
    jle     culled
    mov     ecx, ebx
    call    ExitProcess

culled:
    mov     ecx, 1
    call    ExitProcess
main ENDP

END
