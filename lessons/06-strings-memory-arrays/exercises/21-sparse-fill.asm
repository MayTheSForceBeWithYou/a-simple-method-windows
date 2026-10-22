; Exercise: 21-sparse-fill
;
; Exercise 21: sparse fill
; Fill every other byte in 8-byte buf with 1; sum=4.
; Expected stdout: (none)
;
; Contract: implement `ex_21_sparse_fill` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;

; Exercise 21: 21-sparse-fill (Win32 port)
; Fill every other byte in 8-byte buf with 1; sum=4.
; Build: ml64 /c /Fo21-sparse-fill.obj 21-sparse-fill.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:21-sparse-fill.exe 21-sparse-fill.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_sparse_fill:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_21_sparse_fill in this file.
    call    ex_21_sparse_fill
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
