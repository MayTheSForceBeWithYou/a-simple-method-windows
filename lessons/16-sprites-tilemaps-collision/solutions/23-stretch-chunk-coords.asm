; Exercise 23: stretch chunk coords
;
; STRETCH: chunk = tile>>4; tile=40 -> 2; exit 2.
;
; Build: ml64 /c 23-stretch-chunk-coords.asm && link /OUT:23-stretch-chunk-coords.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-chunk-coords.obj kernel32.lib
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_23_stretch_chunk_coords PROC
mov rax, 40
    shr rax, 4
    mov rcx, rax
    ; return value already in EAX/RAX
    ret
ex_23_stretch_chunk_coords ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_chunk_coords
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
