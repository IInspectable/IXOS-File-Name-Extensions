@echo off

set config=%1
if "%config%" == "" (
   set config=Debug
)

"%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe" "IXOS File Name Extensions.sln" /p:Configuration="%config%" /maxcpucount:3 /v:n

Pause