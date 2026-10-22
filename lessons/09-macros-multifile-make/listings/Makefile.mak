# Sample NMake file for listing 25-nmake-driver.asm
# nmake /f Makefile.mak

all: 25-nmake-driver.exe

25-nmake-driver.exe: 25-nmake-driver.obj
	link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:$@ $** kernel32.lib

.asm.obj:
	ml64 /c $<
