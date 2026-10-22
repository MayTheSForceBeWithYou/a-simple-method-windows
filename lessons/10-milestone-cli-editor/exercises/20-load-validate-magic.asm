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
EXTRN ex_20_load_validate_magic:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_load_validate_magic in this file.
    call    ex_20_load_validate_magic
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
