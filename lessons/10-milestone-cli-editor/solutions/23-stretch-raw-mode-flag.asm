; Exercise 23: stretch raw mode flag
;
; STRETCH: raw_mode byte set/clear; exit 0 after restore.
;
; Build: ml64 /c 23-stretch-raw-mode-flag.asm && link /OUT:23-stretch-raw-mode-flag.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-raw-mode-flag.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.data?
raw BYTE ?

.code

ex_23_stretch_raw_mode_flag PROC
sub rsp, 40
    
    mov BYTE PTR [raw], 1
    mov BYTE PTR [raw], 0
    
    movzx rcx, BYTE PTR [raw]
    mov     eax, 0
    ret
ex_23_stretch_raw_mode_flag ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_raw_mode_flag
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
