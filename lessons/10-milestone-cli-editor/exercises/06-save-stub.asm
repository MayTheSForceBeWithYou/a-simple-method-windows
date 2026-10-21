; 06-save-stub.asm: CreateFile, WriteFile buffer, CloseHandle, exit 0
.DATA
fname DB "test.txt", 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    mov len, 0

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
