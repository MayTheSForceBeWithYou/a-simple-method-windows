; Exercise 21: 21-sparse-fill (Win32 port)
; Fill every other byte in 8-byte buf with 1; sum=4.
; Build: ml64 /c /Fo21-sparse-fill.obj 21-sparse-fill.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-sparse-fill.exe 21-sparse-fill.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sparse_fill:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_21_sparse_fill (student routine; defined in solutions/).
    call    ex_21_sparse_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
