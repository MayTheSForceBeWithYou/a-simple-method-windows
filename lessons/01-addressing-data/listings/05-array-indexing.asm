; Listing 05: Scaled-index addressing for arrays
;
; Purpose: Demonstrate array indexing with proper scaling.
; Expected exit code: 30 (arr[2])
; Expected output: (none)
;
; Build: ml64 /c /Fo05-array-indexing.obj 05-array-indexing.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-array-indexing.exe 05-array-indexing.obj kernel32.lib

.DATA
arr DQ 10, 20, 30, 40, 50     ; Array of 5 quadwords (8 bytes each)
arr_len EQU ($ - arr) / 8

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Load base address
    lea rbx, arr
    
    ; Access arr[2] using scaled index
    mov rcx, 2                 ; Index 2
    mov rax, [rbx+rcx*8]       ; Scale by 8 for quadwords
                               ; RAX = 30
    
    ; Exit with arr[2]
    mov rcx, rax
    call ExitProcess
main ENDP

END
