; Listing 02: Hello, World
;
; Purpose: Complete program that writes "Hello, asm\n" to stdout and exits cleanly.
; Expected exit: 0
; Expected stdout: "Hello, asm\n"
;
; Build: ml64 /c /Fo02-hello-world.obj 02-hello-world.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-hello-world.exe 02-hello-world.obj kernel32.lib

.DATA
msg DB "Hello, asm", 13, 10   ; Message with CR LF (Windows line ending)
msg_len EQU $ - msg            ; Length = 12 bytes

.DATA?
bytes_written DQ ?             ; Storage for WriteFile output parameter

.CODE

EXTRN GetStdHandle:PROC
EXTRN WriteFile:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    push rbx                   ; Save nonvolatile register
    .pushreg rbx
    sub rsp, 48                ; Shadow space + 5th arg slot + alignment
    .allocstack 48
    .endprolog

    ; GetStdHandle(STD_OUTPUT_HANDLE = -11)
    mov ecx, -11               ; STD_OUTPUT_HANDLE
    call GetStdHandle          ; Returns handle in RAX

    mov rbx, rax               ; Save stdout handle in nonvolatile RBX

    ; WriteFile(handle, buffer, count, &bytes_written, NULL)
    mov rcx, rbx               ; arg1: handle
    lea rdx, msg               ; arg2: buffer address
    mov r8d, msg_len           ; arg3: byte count
    lea r9, bytes_written      ; arg4: pointer to bytes written
    mov qword ptr [rsp+32], 0  ; arg5 (on stack): overlapped = NULL
    call WriteFile

    xor ecx, ecx               ; Exit status 0
    call ExitProcess
main ENDP

END
