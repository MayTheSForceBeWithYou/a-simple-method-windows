; Exercise 07: scaled index (Win32 port)
;
; Array DQ 11,22,33,44. Index 2. Use scaled indexing [base+index*8]. Exit with 33.
;
; Build: ml64 /c /Fo07-scaled-index.obj 07-scaled-index.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-scaled-index.exe 07-scaled-index.obj kernel32.lib
; Run: 07-scaled-index.exe & echo %ERRORLEVEL%
;
; Expected exit: 33
; Expected stdout: (none)
.DATA
arr DQ 11, 22, 33, 44

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_scaled_index:PROC

main PROC
    sub     rsp, 40
    ; TODO: LEA base address into RBX
    ; TODO: MOV index 2 into RCX
    ; TODO: MOV RAX, [RBX+RCX*8]
    ; TODO: Exit with RAX
    ; TODO: write ex_07_scaled_index in this file.
    call    ex_07_scaled_index
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
