; Exercise 01: map cell
;
; Set cell type path=1; exit 1.
;
; Build: ml64 /c 01-map-cell.asm && link /OUT:01-map-cell.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-map-cell.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
map BYTE 256 DUP(?)

.code
ex_01_map_cell PROC
    sub rsp, 40
    mov BYTE PTR [map+10], 1
    movzx rcx, BYTE PTR [map+10]
    mov     eax, 1
    ret
ex_01_map_cell ENDP
main PROC
    call    ex_01_map_cell
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
