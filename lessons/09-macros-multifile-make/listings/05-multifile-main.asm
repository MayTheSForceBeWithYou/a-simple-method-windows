; 05-multifile-main.asm
;
; Purpose: Demonstrate multi-file project (main file)
; Expected exit code: 42
; Expected stdout: (none)
;
; This file calls a helper function defined in another file.
; Build:
;   ml64 /c /Fo05-multifile-main.obj 05-multifile-main.asm
;   ml64 /c /Fo05-multifile-helper.obj 05-multifile-helper.asm
;   link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-multifile.exe ^
;        05-multifile-main.obj 05-multifile-helper.obj kernel32.lib

.CODE

EXTRN add_two_numbers:PROC
EXTRN ExitProcess:PROC

main PROC
    mov     rcx, 20         ; First argument (MS x64 ABI)
    mov     rdx, 22         ; Second argument
    call    add_two_numbers ; Returns result in RAX
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 42
main ENDP

END
