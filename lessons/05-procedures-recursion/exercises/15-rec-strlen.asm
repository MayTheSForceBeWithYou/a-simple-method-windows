; Exercise 15: 15-rec-strlen.asm (Win32 port)
; Recursive strlen on "abcd"; exit 4.
; Build: ml64 /c /Fo15-rec-strlen.asm.obj 15-rec-strlen.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-rec-strlen.asm.exe 15-rec-strlen.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_rec_strlen:PROC

; TODO: Port from NASM to MASM

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_15_rec_strlen (student routine; defined in solutions/).
    call    ex_15_rec_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
