; Exercise 14: dirty flag
;
; Edit sets dirty=1; save clears; exit dirty 0.
;
; Build: ml64 /c 14-dirty-flag.asm && link /OUT:14-dirty-flag.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-dirty-flag.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.data?
dirty BYTE ?

.code
ex_14_dirty_flag PROC
    sub rsp, 40
    
    ; Edit sets dirty
    mov BYTE PTR [dirty], 1
    
    ; Save clears dirty
    mov BYTE PTR [dirty], 0
    
    movzx rcx, BYTE PTR [dirty]
    mov     eax, 0
    ret
    add     rsp, 40
ex_14_dirty_flag ENDP
main PROC
    call    ex_14_dirty_flag
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
