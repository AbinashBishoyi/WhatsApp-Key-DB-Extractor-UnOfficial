@echo off

set KIT=JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
if "%VER%" NEQ "" goto FoundJRE

set KIT=Wow6432Node\JavaSoft\Java Runtime Environment
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
if "%VER%" NEQ "" goto FoundJRE

set KIT=JavaSoft\Java Development Kit
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
if "%VER%" NEQ "" goto FoundJRE

set KIT=Wow6432Node\JavaSoft\Java Development Kit
call:ReadRegValue VER "HKLM\Software\%KIT%" "CurrentVersion"
if "%VER%" NEQ "" goto FoundJRE

echo Failed to find Java
goto :EOF

:FoundJRE
call:ReadRegValue JAVA_HOME "HKLM\Software\%KIT%\%VER%" "JavaHome"
echo Using Java from %JAVA_HOME% directory
goto :EOF

:ReadRegValue
set key=%2%
set name=%3%
set "%~1="
set reg=reg
if defined ProgramFiles(x86) (
  if exist %WINDIR%\sysnative\reg.exe set reg=%WINDIR%\sysnative\reg.exe
)
for /F "usebackq tokens=3* skip=1" %%A IN (`%reg% QUERY %key% /v %name% 2^>NUL`) do set "%~1=%%A %%B"
goto :EOF
