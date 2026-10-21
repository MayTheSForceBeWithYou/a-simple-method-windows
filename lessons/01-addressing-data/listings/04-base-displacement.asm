; Listing 04: Base + displacement addressing
;
; Purpose: Access struct-like fields at fixed offsets.
; Expected exit code: 42
; Expected output: (none)
;
; Build: ml64 /c /Fo04-base-displacement.obj 04-base-displacement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-base-displacement.exe 04-base-displacement.obj kernel32.lib

.DATA
person_record:
    DQ 42                      ; Offset 0: age
    DQ 180                     ; Offset 8: height_cm
    DQ 75                      ; Offset 16: weight_kg

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    
    ; Load base address
    lea rbx, person_record
    
    ; Access fields with displacement
    mov rax, [rbx+0]           ; age (42)
    mov rdx, [rbx+8]           ; height (180)
    mov r8, [rbx+16]           ; weight (75)
    
    ; Exit with age
    mov rcx, rax
    call ExitProcess
main ENDP

END
