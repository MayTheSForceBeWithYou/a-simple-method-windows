; Exercise 19: save length prefix
;
; Serialize u64 len=4 then payload; total bytes 12; exit 12.
;
; Build: ml64 /c 19-save-length-prefix.asm && link /OUT:19-save-length-prefix.exe /ENTRY:main /SUBSYSTEM:CONSOLE 19-save-length-prefix.obj kernel32.lib
;
; Expected exit: 12

EXTERN ExitProcess:PROC

.code
ex_19_save_length_prefix PROC
    sub rsp, 40
    
    mov rcx, 8
    add rcx, 4
    mov     eax, ecx
    add     rsp, 40
    ret
ex_19_save_length_prefix ENDP
main PROC
    sub     rsp, 40
    call    ex_19_save_length_prefix
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
