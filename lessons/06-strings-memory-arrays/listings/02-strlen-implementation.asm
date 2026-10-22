; Listing 02: strlen implementation (lines 12-25 of LESSON.md)
;
; Purpose: Count bytes until NUL terminator.
; Expected exit code: 5 (length of "hello")
; Expected output: (none)
;
; Build: ml64 /c /Fo02-strlen-implementation.obj 02-strlen-implementation.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-strlen-implementation.exe 02-strlen-implementation.obj kernel32.lib

.DATA
test_str DB "hello", 0

.CODE

EXTRN ExitProcess:PROC

; strlen(RCX) -> RAX
my_strlen PROC
    mov rax, rcx               ; RAX = pointer
scan:
    cmp BYTE PTR [rax], 0      ; Check for NUL
    je done
    inc rax
    jmp scan
done:
    sub rax, rcx               ; Length = end - start
    ret
my_strlen ENDP

main PROC
    sub rsp, 40
    lea rcx, test_str
    call my_strlen
    mov rcx, rax
    call ExitProcess
main ENDP

END
