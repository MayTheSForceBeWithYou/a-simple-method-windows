; Exercise 14: path reconstruct
;
; Path length 4; exit 4.
;
; Build: ml64 /c 14-path-reconstruct.asm && link /OUT:14-path-reconstruct.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-path-reconstruct.obj kernel32.lib
;
; Expected exit: 4
; Expected stdout: (none)
;

EXTERN ExitProcess:PROC

.code
ex_14_path_reconstruct PROC
    sub rsp, 40
        mov     eax, ecx
    add     rsp, 40
    ret
ex_14_path_reconstruct ENDP
main PROC
    sub     rsp, 40
    call    ex_14_path_reconstruct
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
