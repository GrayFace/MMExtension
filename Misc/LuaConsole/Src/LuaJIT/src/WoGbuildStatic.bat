:: See msvcbuild.bat for instructions

cd %~dp0
del lua51.lib.bak
del lua51.exp.bak
move lua51.lib lua51.lib.bak
move lua51.exp lua51.exp.bak
call msvcbuild.bat static
del lua51static.lib
move lua51.lib lua51static.lib
del luajit.exe
del lua51.dll
del lua51.exp
move lua51.lib.bak lua51.lib
move lua51.exp.bak lua51.exp
