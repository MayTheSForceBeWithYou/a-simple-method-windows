; Listing 02: MS x64 calling convention - argument passing
;
; Purpose: Demonstrate MS x64 ABI argument registers (RCX, RDX, R8, R9).
; Expected exit code: 10
; Expected output: (none)
;
; Note: MS x64 differs from System V AMD64:
; - Args: RCX, RDX, R8, R9 (not RDI, RSI, RDX, RCX)
; - Requires 32-byte shadow space on stack
; - Caller allocates shadow space; callee can use it
;
; Build: ml64 /c /Fo02-ms-x64-args.obj 02-ms-x64-args.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-ms-x64-args.exe 02-ms-x64-args.obj kernel32.lib

.CODE

EXTRN ExitProcess:PROC

; Function: add_four(a, b, c, d) -> a + b + c + d
; MS x64 ABI: RCX=a, RDX=b, R8=c, R9=d
add_four PROC
    mov rax, rcx               ; RAX = a
    add rax, rdx               ; RAX += b
    add rax, r8                ; RAX += c
    add rax, r9                ; RAX += d
    ret
add_four ENDP

main PROC
    sub rsp, 40                ; Shadow space
    
    ; Call add_four(1, 2, 3, 4)
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    call add_four              ; RAX = 10
    
    mov rcx, rax
    call ExitProcess
main ENDP

END
