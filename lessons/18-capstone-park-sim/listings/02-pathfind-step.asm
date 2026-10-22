; One A* pathfinding step, exit 0
; Expected exit: 0
; Expected stdout: (none)
.DATA?
open_list QWORD 16 DUP(?)
closed_list QWORD 16 DUP(?)
.CODE
EXTRN ExitProcess:PROC
main PROC
    sub rsp, 40
    xor ecx, ecx
    call ExitProcess
main ENDP
END
