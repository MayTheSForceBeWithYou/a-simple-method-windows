; Exercise 19: 19-compare-procs.asm (Win32 port)
; cmp_i64(a,b) returns -1/0/1. cmp(3,5) -> -1; exit with al=255 via movzx of signed? Use add 1 -> 0 exit for less. Better: return 0 for less,1 eq,2 greater; exit 0.
; Build: ml64 /c /Fo19-compare-procs.asm.obj 19-compare-procs.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:19-compare-procs.asm.exe 19-compare-procs.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_compare_procs:PROC

; TODO: Port from NASM to MASM

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_19_compare_procs (student routine; defined in solutions/).
    call    ex_19_compare_procs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
