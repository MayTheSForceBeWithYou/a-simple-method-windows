; 07-load-stub.asm: Open file, ReadFile into buffer, CloseHandle, exit len
.DATA
fname DB "test.txt", 0
.DATA?
buf DB 256 DUP(?)
len QWORD ?
bytesRead DWORD ?
.CODE
EXTRN CreateFileA:PROC
EXTRN ReadFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_07_load_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_07_load_stub in this file.
    call    ex_07_load_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
