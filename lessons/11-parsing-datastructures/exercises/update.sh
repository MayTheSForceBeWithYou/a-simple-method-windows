#!/bin/bash
for f in *.asm; do
echo "; ${f%.asm}
.CODE
EXTRN ExitProcess:PROC
.ERR <TODO: Implement ${f%.asm}>
main PROC
.ERR <TODO>
main ENDP
END" > "$f"
done
