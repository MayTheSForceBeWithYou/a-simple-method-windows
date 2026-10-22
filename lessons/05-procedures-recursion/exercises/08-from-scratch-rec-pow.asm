; Exercise 08: from scratch rec pow (Win32 port)
; FROM SCRATCH: pow(base,exp) recursive multiply. pow(2,5)=32; exit 32.
; Build: ml64 /c /Fo08-from-scratch-rec-pow.obj 08-from-scratch-rec-pow.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-from-scratch-rec-pow.exe 08-from-scratch-rec-pow.obj kernel32.lib
; Expected: exit code 32

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive pow(RCX=base, RDX=exp)

main PROC
    sub     rsp, 32
    mov rcx, 2
    mov rdx, 5
    call pow
    mov rcx, rax
    call ExitProcess
main ENDP
END
