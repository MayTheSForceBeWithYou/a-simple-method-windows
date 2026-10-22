; Exercise 24: from scratch overlap area
;
; FROM SCRATCH: overlap width 2 height 3 area 6; exit 6.
;
; Build: ml64 /c 24-from-scratch-overlap-area.asm && link /OUT:24-from-scratch-overlap-area.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-overlap-area.obj kernel32.lib
;
; Expected exit: 6
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_24_from_scratch_overlap_area PROC
    sub rsp, 40
    mov rcx, 2
    imul rcx, 3
    mov     eax, 6
    ret
ex_24_from_scratch_overlap_area ENDP
main PROC
    call    ex_24_from_scratch_overlap_area
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
