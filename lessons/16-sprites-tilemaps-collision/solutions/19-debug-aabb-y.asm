; Exercise 19: debug aabb y
;
; BUG: used x test for y. Fix overlap on y; exit 1 for overlap.
;
; Build: ml64 /c 19-debug-aabb-y.asm && link /OUT:19-debug-aabb-y.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-debug-aabb-y.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_19_debug_aabb_y PROC
    sub rsp, 40
    ; a.y=0 a.h=2; b.y=1 b.h=2 overlap
        mov     eax, 1
    add     rsp, 40
    ret
ex_19_debug_aabb_y ENDP
main PROC
    call    ex_19_debug_aabb_y
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
