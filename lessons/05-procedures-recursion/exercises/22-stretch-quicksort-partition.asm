; Exercise: 22-stretch-quicksort-partition
;
; Exercise 22: stretch partition
; Lomuto partition for [1,5,2,4]. Returns pivot index. Exit pivot index (2 or 3 depending).
;
; Contract: implement `ex_22_stretch_quicksort_partition` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 22: 22-stretch-quicksort-partition.asm (Win32 port)
; STRETCH: partition helper for [1,5,2,4] pivot last; after partition count of elems <=pivot left. Simpler: partition returns final pivot index for arr. Exit index 2 for this data if pivot=4... Use lomuto; exit pivot index.
; Build: ml64 /c /Fo22-stretch-quicksort-partition.asm.obj 22-stretch-quicksort-partition.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:22-stretch-quicksort-partition.asm.exe 22-stretch-quicksort-partition.asm.obj kernel32.lib
; Expected: see original exercise

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_22_stretch_quicksort_partition:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_22_stretch_quicksort_partition in this file.
    call    ex_22_stretch_quicksort_partition
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
