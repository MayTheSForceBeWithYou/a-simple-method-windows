; Exercise 04: mov vs lea (Win32 port) - SOLUTION
;
; Label x DQ 99. LEA RBX,[x] then MOV RAX,[RBX]. Exit with 99.
; Add comments explaining which instruction computes address vs loads value.
;
; Build: ml64 /c /Fo04-mov-vs-lea.obj 04-mov-vs-lea.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-mov-vs-lea.exe 04-mov-vs-lea.obj kernel32.lib
; Run: 04-mov-vs-lea.exe & echo %ERRORLEVEL%
;
; Expected: exit code 99

.DATA
x DQ 99

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    lea rbx, x                 ; Compute address of x (no memory access)
    mov rax, [rbx]             ; Load value from that address (memory read)
    mov rcx, rax               ; Move to exit parameter
    call ExitProcess
    
main ENDP

END
