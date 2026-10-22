; Exercise 15: makefile phony doc
;
; Documents build script; program exits 0. Read comment about build targets.
;
; Build: ml64 /c 15-makefile-phony-doc.asm && link /OUT:15-makefile-phony-doc.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-makefile-phony-doc.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

; Example PowerShell build script (not executed):
; # Build all
; $sources = Get-ChildItem *.asm
; foreach ($src in $sources) {
;     ml64 /c $src.Name
; }
; link *.obj /OUT:prog.exe /ENTRY:main /SUBSYSTEM:CONSOLE kernel32.lib

.code
ex_15_makefile_phony_doc PROC
    sub rsp, 40
        mov     eax, ecx
    add     rsp, 40
    ret
ex_15_makefile_phony_doc ENDP
main PROC
    sub     rsp, 40
    call    ex_15_makefile_phony_doc
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
