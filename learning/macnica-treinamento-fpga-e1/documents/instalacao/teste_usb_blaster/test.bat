@echo off
set dir=%~dp0
set dir=%dir:\=/%
"%QSYS_ROOTDIR%\..\..\..\quartus\bin64\quartus_pgm.exe" -m jtag -o "p;%dir%/test_files/test.sof"
IF %ERRORLEVEL% EQU 0 ( 
  echo === SUCCESS === 
) ELSE ( 
  echo ERRO
)
pause
