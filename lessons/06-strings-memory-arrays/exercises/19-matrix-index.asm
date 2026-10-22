; Exercise 19: 19-matrix-index (Win32 port)
; Row-major 3x3; get (r=1,c=2) from 1..9 matrix -> 6.
; Build: ml64 /c /Fo19-matrix-index.obj 19-matrix-index.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:19-matrix-index.exe 19-matrix-index.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_matrix_index:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)

main PROC
    sub     rsp, 40
    ; TODO: Implement
    ; TODO: write ex_19_matrix_index in this file.
    call    ex_19_matrix_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
