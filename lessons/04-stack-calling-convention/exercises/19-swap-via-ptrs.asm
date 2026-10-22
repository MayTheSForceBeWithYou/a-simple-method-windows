; Exercise 19: swap via ptrs (Win32 port)
; swap(RCX=&a, RDX=&b). a=1, b=2; after swap exit a (2).
; Build: ml64 /c /Fo19-swap-via-ptrs.obj 19-swap-via-ptrs.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:19-swap-via-ptrs.exe 19-swap-via-ptrs.obj kernel32.lib
; Expected: exit code 2

.DATA
a DQ 1
b DQ 2

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement swap(RCX=ptr1, RDX=ptr2)

main PROC
    sub     rsp, 32
    lea rcx, a
    lea rdx, b
    call swap
    mov rcx, a
    call ExitProcess
main ENDP
END
