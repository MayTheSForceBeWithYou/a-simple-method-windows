; Exercise: 22-stretch-file-copy-mem
;
; STRETCH: copy 4 bytes between two VirtualAlloc regions; checksum 10 for 1,2,3,4.
;
; Contract: implement `ex_22_stretch_file_copy_mem` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.DATA
source DB 2, 3, 4, 1    ; Sum = 10

.CODE

EXTRN VirtualAlloc:PROC
EXTRN VirtualFree:PROC
EXTRN ExitProcess:PROC
EXTERNDEF ex_22_stretch_file_copy_mem:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_22_stretch_file_copy_mem in this file.
    call    ex_22_stretch_file_copy_mem
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
