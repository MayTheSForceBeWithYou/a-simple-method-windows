; Exercise 07: row fill
;
; Fill 3 pixels with 9; exit mid.
;
; Build: ml64 /c 07-row-fill.asm && link /OUT:07-row-fill.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-row-fill.obj kernel32.lib
;
; Expected exit: 9
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
row BYTE 3 DUP(?)

.code
ex_07_row_fill PROC
    sub rsp, 40
    mov BYTE PTR [row], 9
    mov BYTE PTR [row+1], 9
    mov BYTE PTR [row+2], 9
    movzx rcx, BYTE PTR [row+1]
    mov     eax, 9
    ret
    add     rsp, 40
ex_07_row_fill ENDP
main PROC
    call    ex_07_row_fill
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
