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
    ; TODO: implement ex_19_save_length_prefix (student routine; defined in solutions/).
    call    ex_19_save_length_prefix
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
