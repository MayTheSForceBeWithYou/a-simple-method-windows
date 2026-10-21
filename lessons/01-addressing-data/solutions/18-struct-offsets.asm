; Exercise 18: struct offsets
;
; Simulate struct {QWORD a; QWORD b; BYTE c;}: set a=1,b=2,c=3. Exit a+b+c=6 using explicit offsets 0,8,16.
;
; Build: ml64 /c 18-struct-offsets.asm && link /OUT:18-struct-offsets.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-struct-offsets.obj kernel32.lib
;
; Expected exit: 6

EXTERN ExitProcess:PROC

.data?
s QWORD 3 DUP(?)

.code
main PROC
    sub rsp, 40
    mov QWORD PTR [s], 1
    mov QWORD PTR [s+8], 2
    mov BYTE PTR [s+16], 3
    mov rcx, [s]
    add rcx, [s+8]
    movzx rax, BYTE PTR [s+16]
    add rcx, rax
    call ExitProcess
main ENDP
END
