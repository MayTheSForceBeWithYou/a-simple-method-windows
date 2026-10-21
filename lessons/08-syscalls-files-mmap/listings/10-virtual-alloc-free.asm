; Listing 10: VirtualAlloc one page, write byte, VirtualFree (LESSON.md asm block 10)
;
; Purpose: Anonymous RW page via VirtualAlloc; release with MEM_RELEASE.
; Expected exit: 42 (byte stored in allocated page)
; Expected stdout: (none)
;
; Build: ml64 /c /Fo10-virtual-alloc-free.obj 10-virtual-alloc-free.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-virtual-alloc-free.exe 10-virtual-alloc-free.obj kernel32.lib

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN GetLastError:PROC
EXTRN ExitProcess:PROC

main PROC FRAME
    sub rsp, 40
    .allocstack 40
    .endprolog

    xor ecx, ecx
    mov edx, 4096
    mov r8d, 3000h
    mov r9d, 4
    call VirtualAlloc
    test rax, rax
    jz alloc_failed

    mov BYTE PTR [rax], 42

    mov rcx, rax
    xor edx, edx
    mov r8d, 8000h
    call VirtualFree
    test rax, rax
    jz free_failed

    mov ecx, 42
    call ExitProcess

alloc_failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess

free_failed:
    call GetLastError
    mov ecx, eax
    call ExitProcess
main ENDP

END
