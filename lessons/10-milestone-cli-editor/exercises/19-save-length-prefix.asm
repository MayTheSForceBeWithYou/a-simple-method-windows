; 19-save-length-prefix.asm: Save magic+len+data to file, exit 0
.DATA
fname DB "save.dat", 0
MAGIC EQU 12345678h
.DATA?
buf DB 256 DUP(?)
len QWORD ?
written DWORD ?
.CODE
EXTRN CreateFileA:PROC
EXTRN WriteFile:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC
EXTRN ex_19_save_length_prefix:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_19_save_length_prefix in this file.
    call    ex_19_save_length_prefix
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
