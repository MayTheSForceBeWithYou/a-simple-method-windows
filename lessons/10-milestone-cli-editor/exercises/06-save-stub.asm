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
EXTRN ex_06_save_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_06_save_stub (student routine; defined in solutions/).
    call    ex_06_save_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
