; Exercise 11: 11-map-array-proc.asm (Win32 port)
; apply_inc: for each of 4 qwords, +=1 via procedure. Sum after = 14 for {1,2,3,4}->15? 2+3+4+5=14. Exit 14.
; Build: ml64 /c /Fo11-map-array-proc.asm.obj 11-map-array-proc.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-map-array-proc.asm.exe 11-map-array-proc.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_map_array_proc:PROC

; TODO: Port from NASM to MASM

main PROC
    sub     rsp, 32
    ; TODO: Implement
    ; TODO: implement ex_11_map_array_proc (student routine; defined in solutions/).
    call    ex_11_map_array_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
