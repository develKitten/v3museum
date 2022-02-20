::
::  dosKorea ver. 1.0
::  
::  > helps the DOS-BOX support Korean.
::  > Developed by Se-Eun Kim
::

@ECHO OFF & setlocal
 
:: 0. get user name and path
SET currentPath=%~dp0
for /f "tokens=1,2,3,4 delims=\" %%a in ("%currentPath%") do (
    SET drive=%%a
    SET userName=%%c
)
SET DosBoxSetPath=%drive%:\Users\%userName%\AppData\Local\DOSBox
echo %DosBoxSetPath%

if not exist %DosBoxSetPath% (
    echo [Error] DOSBox doesn't installed.
    GOTO:EOF
)

:: 1. download korean.lang and move file
if not exist %DosBoxSetPath%\korean.lang (
    Powershell.exe Invoke-WebRequest -uri "https://www.dosbox.com/tools/DOSBox-kor-lang-0.72.zip" ^
                                     -OutFile "DOSBox-kor-lang.zip"

    mkdir kor
    move "DOSBox-kor-lang.zip" kor

    cd /d kor & tar -xzvf "DOSBox-kor-lang.zip"
    cd /d .. & move "kor\korean.lang" %DosBoxSetPath%

    rd /S /Q kor

) else (
    echo korean.lang exists already.
    PAUSE
)