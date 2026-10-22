; Exercise 02: aabb overlap
;
; Overlap test true -> 1.
;
; Build: ml64 /c 02-aabb-overlap.asm && link /OUT:02-aabb-overlap.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-aabb-overlap.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_02_aabb_overlap PROC
    sub rsp, 40
    ; a[0,0,2,2] b[1,1,3,3]
        mov     eax, 1
    add     rsp, 40
    ret
ex_02_aabb_overlap ENDP
main PROC
    sub     rsp, 40
    call    ex_02_aabb_overlap
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
