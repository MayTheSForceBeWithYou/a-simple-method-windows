; Exercise 24: 24-from-scratch-rec-sum-array.asm (Win32 port)
; FROM SCRATCH: rec_sum(arr,n) sums n qwords. {2,3,4} n=3 -> 9.
; Build: ml64 /c /Fo24-from-scratch-rec-sum-array.asm.obj 24-from-scratch-rec-sum-array.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:24-from-scratch-rec-sum-array.asm.exe 24-from-scratch-rec-sum-array.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM

main PROC
    sub rsp, 32
    ; TODO: Implement

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 1
    call ExitProcess
main ENDP
END
