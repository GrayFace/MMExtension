:: See msvcbuild.bat for instructions

cd %~dp0
call msvcbuild.bat
copy /Y lua51.dll ..\..\..\lua51.dll
del luajit.exe
del lua51.dll
