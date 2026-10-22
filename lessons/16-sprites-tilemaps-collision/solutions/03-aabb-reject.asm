; Exercise 03: aabb reject
;
; No overlap -> 0.
;
; Build: ml64 /c 03-aabb-reject.asm && link /OUT:03-aabb-reject.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-aabb-reject.obj kernel32.lib
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_03_aabb_reject PROC
    sub rsp, 40
    xor rcx, rcx
    mov     eax, 0
    add     rsp, 40
    ret
ex_03_aabb_reject ENDP
main PROC
    call    ex_03_aabb_reject
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
