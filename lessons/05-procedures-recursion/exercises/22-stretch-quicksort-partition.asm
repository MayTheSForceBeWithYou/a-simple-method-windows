; Exercise 22: 22-stretch-quicksort-partition.asm (Win32 port)
; STRETCH: partition helper for [1,5,2,4] pivot last; after partition count of elems <=pivot left. Simpler: partition returns final pivot index for arr. Exit index 2 for this data if pivot=4... Use lomuto; exit pivot index.
; Build: ml64 /c /Fo22-stretch-quicksort-partition.asm.obj 22-stretch-quicksort-partition.asm.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:22-stretch-quicksort-partition.asm.exe 22-stretch-quicksort-partition.asm.obj kernel32.lib
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
