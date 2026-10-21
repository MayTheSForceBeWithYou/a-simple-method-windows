; 20-load-validate-magic.asm: Load file, check magic, exit 0 if valid else 1
.DATA
fname DB "save.dat", 0
MAGIC EQU 12345678h
.DATA?
fileMagic DWORD ?
fileLen QWORD ?
buf DB 256 DUP(?)
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

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
