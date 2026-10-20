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
main PROC FRAME
    sub rsp, 56
    .allocstack 56
    .endprolog
    .ERR <TODO: CreateFileA(OPEN_EXISTING), ReadFile, set len=bytesRead, exit len>
main ENDP
END
