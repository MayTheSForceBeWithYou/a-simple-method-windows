# Windows Port Phase 2 - Prose Rewrite Status

**Author:** Monk (prose author)
**Branch:** `cursor/monk-prose-4c38`
**Status:** IN PROGRESS

## Completed Lessons (5/19)

### ✅ Lesson 00 — Tools, Registers, `mov`, Win32 API Calls
- Replaced NASM with MASM (ml64.exe)
- Replaced Linux syscalls with Win32 API (GetStdHandle, WriteConsoleA, ExitProcess)
- Replaced System V ABI with MS x64 calling convention
- Introduced shadow space requirement (32 bytes)
- Updated all code examples with PROC/ENDP syntax
- Added LISTING-PENDING markers for standalone listings

### ✅ Lesson 01 — Addressing Modes & Data Sections
- Replaced ELF sections (.text/.data/.rodata/.bss) with MASM/PE sections (.code/.data/.const/.data?)
- Updated data directives: `resb`/`resq` → `BYTE N DUP(?)`/`QWORD N DUP(?)`
- Updated size specifiers: `byte [addr]` → `BYTE PTR [addr]`
- Explained MASM's automatic RIP-relative addressing in 64-bit mode
- Updated worked examples with shadow space

### ✅ Lesson 02 — Arithmetic & Flags
- Minimal changes (arithmetic/flags are platform-independent)
- Updated worked example to use main PROC and ExitProcess
- Replaced SIGFPE with Windows exception terminology (EXCEPTION_INT_OVERFLOW)
- Updated build commands

### ✅ Lesson 03 — Control Flow
- Minimal changes (control flow is platform-independent)
- Updated worked example with shadow space allocation
- Updated jump table to MASM syntax (.const, QWORD PTR)
- Changed local labels to MASM convention (descriptive names vs . prefix)

### ✅ Lesson 04 — Stack & Microsoft x64 Calling Convention
- **MAJOR REWRITE** - Core ABI lesson
- Replaced System V AMD64 with Microsoft x64 throughout
- Changed argument registers: RDI/RSI/RDX/RCX/R8/R9 → RCX/RDX/R8/R9 (only 4 register args)
- Replaced red zone (Linux) with shadow space (Windows, 32 bytes, mandatory)
- Updated volatile/nonvolatile registers: RSI/RDI are **nonvolatile on Windows** (opposite of Linux)
- Explained 16-byte stack alignment + shadow space calculation
- Comprehensive worked examples with MS x64 convention

## Remaining Lessons (14/19)

### Lesson 05 — Procedures & Recursion
**Status:** TODO
**Complexity:** Medium (similar to L04, ABI-dependent)
**Key changes:**
- Update all function examples to use MS x64 calling convention
- Update recursive examples with correct shadow space allocation
- Save/restore nonvolatile registers (RSI, RDI)

### Lesson 06 — Strings, Memory, Arrays
**Status:** TODO
**Complexity:** Low (direct port)
**Key changes:**
- Update exit mechanism to ExitProcess
- Minor MASM syntax updates

### Lesson 07 — Bit Operations, Shifts, Masks
**Status:** TODO
**Complexity:** Low (direct port, platform-independent)
**Key changes:**
- Update exit mechanism
- Build commands

### Lesson 08 — Syscalls, Files, mmap
**Status:** TODO
**Complexity:** HIGH ⚠️ (major API rewrite)
**Key changes:**
- Replace `open/read/write/close/lseek` with `CreateFileA/ReadFile/WriteFile/CloseHandle/SetFilePointerEx`
- Replace `mmap/munmap` with `VirtualAlloc/VirtualFree`
- Replace `brk` with `HeapAlloc` or note no equivalent
- Update error handling: negative errno → BOOL + GetLastError
- File descriptors → HANDLEs
- Explain Win32 file API comprehensively

### Lesson 09 — Macros, Multi-file, Make
**Status:** TODO
**Complexity:** Medium
**Key changes:**
- Replace NASM `%macro` with MASM `MACRO`
- Update multi-file linking (EXTERN/PUBLIC)
- Replace Makefile with PowerShell build script or note nmake

### Lesson 10 — Milestone: CLI Text Editor
**Status:** TODO
**Complexity:** HIGH ⚠️ (termios → console API)
**Key changes:**
- Replace `ioctl TCGETS/TCSETS` with `GetConsoleMode/SetConsoleMode`
- Replace termios flags with console mode flags (ENABLE_LINE_INPUT, ENABLE_ECHO_INPUT)
- Update keypress reading: ReadConsoleInput or ReadFile with line-input disabled
- File I/O already covered in L08

### Lesson 11 — Parsing & Data Structures
**Status:** TODO
**Complexity:** Low (direct port, pure algorithm)
**Key changes:**
- Update exit mechanism
- Memory allocation references (use VirtualAlloc from L08)

### Lesson 12 — Milestone: Tiny Compiler
**Status:** TODO
**Complexity:** Medium
**Key changes:**
- If compiler emits machine code, teach PE format instead of ELF (or emit MASM source)
- Parser/lexer/codegen are platform-independent

### Lesson 13 — Fixed-Point, SIMD
**Status:** TODO
**Complexity:** Low (direct port, instructions are identical)
**Key changes:**
- Update exit mechanism

### Lesson 14 — Graphics, Framebuffer
**Status:** TODO
**Complexity:** Low (file I/O from L08)
**Key changes:**
- PPM output uses CreateFileA+WriteFile
- Pixel math is platform-independent

### Lesson 15 — Input, Timing, Game Loop
**Status:** TODO
**Complexity:** Medium
**Key changes:**
- Replace `clock_gettime` with `QueryPerformanceCounter + QueryPerformanceFrequency`
- Replace `nanosleep` with `Sleep(milliseconds)`
- Console input from L10
- Replace `poll` with `WaitForSingleObject` if needed

### Lesson 16 — Sprites, Tilemaps, Collision
**Status:** TODO
**Complexity:** Low (direct port, pure algorithm)
**Key changes:**
- AABB, spatial hash, tile indexing are platform-independent

### Lesson 17 — Entities, Pathfinding, UI
**Status:** TODO
**Complexity:** Low (direct port, pure algorithm)
**Key changes:**
- ECS, BFS, A*, UI hit-testing are platform-independent

### Lesson 18 — Capstone: Mini Park Sim
**Status:** TODO
**Complexity:** Medium (integrates all Win32 concepts)
**Key changes:**
- File I/O from L08
- Timing from L15
- Console from L10
- Game loop and sim logic are platform-independent

### docs/LEARNING_ROADMAP.md
**Status:** TODO
**Complexity:** Medium
**Key changes:**
- Update toolchain section: Arch Linux WSL → Windows 11 + Visual Studio
- Update build commands: nasm/ld → ml64/link
- Update syscall references to Win32 API
- Update lesson descriptions for Windows-specific content

## Patterns Established (Lessons 00-04)

These patterns are now consistently applied:

1. **Entry point:** `_start` → `main PROC ... main ENDP ... END`
2. **Exit:** `syscall` (rax=60, rdi=status) → `ExitProcess` (rcx=status)
3. **Sections:** `.text/.data/.rodata/.bss` → `.code/.data/.const/.data?`
4. **Data directives:** `db/resb` → `BYTE/BYTE N DUP(?)`
5. **Size specifiers:** `byte [addr]` → `BYTE PTR [addr]`
6. **Calling convention:** System V (RDI/RSI/RDX/RCX/R8/R9, 6 args) → MS x64 (RCX/RDX/R8/R9, 4 args)
7. **Shadow space:** Required 32 bytes before every call
8. **Alignment:** RSP must be 16-byte aligned before call (allocate shadow + locals in multiples of 16)
9. **Nonvolatile registers:** **RSI/RDI are nonvolatile on Windows** (must save/restore if used)
10. **Build commands:** `nasm -f elf64 ... && ld ...` → `ml64 /c ... && link /ENTRY:main /SUBSYSTEM:CONSOLE ... kernel32.lib`
11. **LISTING-PENDING markers:** Added for all code blocks to be extracted by listings author

## Technical Flags File

All technical doubts are tracked in `docs/PROSE_TECH_FLAGS.md` for reviewer verification.

## Next Steps

1. Complete lessons 05-18 (14 remaining)
2. Update LEARNING_ROADMAP.md
3. Create PR body with:
   - Summary of per-lesson changes
   - List of all LISTING-PENDING markers
   - Link to PROSE_TECH_FLAGS.md
4. Mark PR ready for review (not draft)

## Notes for Technical Reviewer

- All Win32 API usage follows the spec in `docs/WINDOWS_PORT_SPEC.md`
- MS x64 calling convention is correctly applied throughout
- Shadow space and alignment are properly explained and demonstrated
- Platform differences (RSI/RDI nonvolatile, 4 vs 6 register args, shadow space vs red zone) are clearly called out
- Code blocks are marked with LISTING-PENDING where standalone listings will be created
- Build commands reference x64 Native Tools Command Prompt and ml64/link.exe
