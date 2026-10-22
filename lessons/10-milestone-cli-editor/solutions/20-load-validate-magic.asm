; Exercise 20: load validate magic
;
; Magic "ED01"; check first two ED; exit 1 if ok.
;
; Build: ml64 /c 20-load-validate-magic.asm && link /OUT:20-load-validate-magic.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-load-validate-magic.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
magic BYTE "ED01"

.code
ex_20_load_validate_magic PROC
    sub rsp, 40
    
    cmp WORD PTR [magic], 4445h  ; "ED" in little-endian
    jne L_n
    
    mov rcx, 1
    jmp L_o
    
L_n:
    xor rcx, rcx
    
L_o:
    mov     eax, 1
    add     rsp, 40
    ret
ex_20_load_validate_magic ENDP
main PROC
    call    ex_20_load_validate_magic
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
