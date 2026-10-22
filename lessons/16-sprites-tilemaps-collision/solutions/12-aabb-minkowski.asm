; Exercise 12: aabb minkowski
;
; Minkowski expand by 1; width 4->6; exit 6.
;
; Build: ml64 /c 12-aabb-minkowski.asm && link /OUT:12-aabb-minkowski.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-aabb-minkowski.obj kernel32.lib
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_12_aabb_minkowski PROC
sub rsp, 40
    mov rcx, 4
    add rcx, 2
    mov     eax, 6
    ret
ex_12_aabb_minkowski ENDP
main PROC
    sub     rsp, 40
    call    ex_12_aabb_minkowski
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
