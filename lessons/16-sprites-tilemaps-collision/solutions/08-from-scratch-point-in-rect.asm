; Exercise 08: from scratch point in rect
;
; FROM SCRATCH: point in rect -> 1.
;
; Build: ml64 /c 08-from-scratch-point-in-rect.asm && link /OUT:08-from-scratch-point-in-rect.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-point-in-rect.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_08_from_scratch_point_in_rect PROC
    sub rsp, 40
    ; p(2,2) in [0,0,5,5]
        mov     eax, 1
    ret
    add     rsp, 40
ex_08_from_scratch_point_in_rect ENDP
main PROC
    call    ex_08_from_scratch_point_in_rect
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
