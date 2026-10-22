; Exercise: 22-stretch-quicksort-partition
;
; Lomuto partition for [1,5,2,4]. Returns pivot index. Exit pivot index (2 or 3 depending).
;
; Contract: implement `ex_22_stretch_quicksort_partition` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_quicksort_partition:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_22_stretch_quicksort_partition in this file.
    call    ex_22_stretch_quicksort_partition
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
