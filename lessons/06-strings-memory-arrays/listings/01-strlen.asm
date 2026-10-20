; Listing 01: String length function
;
; Purpose: Implement strlen - count bytes until null terminator.
; Expected exit code: 11 (length of "Hello world")
; Expected output: (none)
;
; Build: ml64 /c /Fo01-strlen.obj 01-strlen.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-strlen.exe 01-strlen.obj kernel32.lib

.DATA
test_str DB "Hello world", 0

.CODE

EXTRN ExitProcess:PROC

; strlen(str): returns length of null-terminated string
; RCX = pointer to string
; Returns: RAX = length
my_strlen PROC
    xor rax, rax               ; Length = 0
loop_start:
    cmp BYTE PTR [rcx+rax], 0  ; Check for null terminator
    je loop_done
    inc rax
    jmp loop_start
loop_done:
    ret
my_strlen ENDP

main PROC
    sub rsp, 32
    
    lea rcx, test_str
    call my_strlen             ; RAX = 11
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
