; Exercise: 24-from-scratch-rec-sum-array
;
; Exercise 24: from scratch rec sum array
; FROM SCRATCH: rec_sum(arr,n) sums n qwords. {2,3,4} n=3 -> 9.
; Expected stdout: (none)
;
; Contract: implement `ex_24_from_scratch_rec_sum_array` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; Exercise 24: 24-from-scratch-rec-sum-array.asm (Win32 port)
; FROM SCRATCH: rec_sum(arr,n) sums n qwords. {2,3,4} n=3 -> 9.
; Build: ml64 /c /Fo24-from-scratch-rec-sum-array.asm.obj 24-from-scratch-rec-sum-array.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:24-from-scratch-rec-sum-array.asm.exe 24-from-scratch-rec-sum-array.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_rec_sum_array:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_24_from_scratch_rec_sum_array in this file.
    call    ex_24_from_scratch_rec_sum_array
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
