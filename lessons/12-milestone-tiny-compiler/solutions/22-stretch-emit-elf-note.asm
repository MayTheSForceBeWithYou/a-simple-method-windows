; Exercise 22: stretch emit elf note
;
; STRETCH: document emitting ELF; exit header size stub 64.
; Expected exit: 64

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rcx, 64
    call ExitProcess
main ENDP
END
