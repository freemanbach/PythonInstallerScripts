@echo OFF

REM Auth          : Freeman
REM Email         : flo@radford.edu
REM DESC          : Silent Python Installer for Windows
REM 32bit path    : https://www.python.org/ftp/python/3.11.4/python-3.11.4.exe
REM 64bit path    : https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe
REM Date          : 2023.08.14

set major=3
set minor=11
set patch=4

set badmin32=C:\Windows\System32\bitsadmin.exe
set badmin64=C:\Windows\SysWOW64\bitsadmin.exe

:: Check Admin DOS PROMPT is available
goto check_permission
:check_permission
    setlocal
    echo. Administrative permissions required. Detecting permissions..
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo. Admin Permissions confirmed.
        echo. Continuing.......
    ) else (
        echo. Admin Permissions not confirmed. 
        echo. Right click on the DOS Prompt and RUN AS Administrator
        echo. Exiting..........
        goto end
    )

:time_pause2
    timeout /t 2 > nul

:: clear screen
cls

:: Prompt for user to Really run this script
:start_this
    setlocal
    set _value="n"
    set /p _value=Are you sure to update Python packages x86_64 or x86 (y/[n]) ?
    if /i "%_value%" NEQ "y" goto end

:: This batch file will show details Windows 10, and install Python v3.10.9
:section_0
    setlocal
    title Update Python PIP Packages on Windows 7/8/9/10/11
    echo.
    timeout /t 2 > nul
    rem Switch to Downloads early on
    cd C:\Users\%USERNAME%\Downloads

:time_pause2
    timeout /t 2 > nul

:: Check to see if Python was installed in the location
:: we are hoping to find a previous installation
:section_1
    echo.
    echo. ========================
    echo. Updating pip
    echo. ========================
    echo.
    if exist C:\Python%major%%minor%%patch%\Scripts\pip.exe (
        rem Updating pip on Windows
        echo.
        C:\Python%major%%minor%%patch%\python.exe -m pip install --upgrade pip
        echo.
    ) else (
        echo.
        echo. PIP was not installed or we dont know where PIP was installed.
        echo. 
        goto end
    )

:time_pause2
    timeout /t 2 > nul

:: Updating the packages
:section_2
    echo.
    echo. ========================
    echo. Updating pip packages
    echo. ========================
    echo.
    if exist C:\Python%major%%minor%%patch%\Scripts\pip.exe (
        rem Updating pip on Windows
        echo.
        C:\Python%major%%minor%%patch%\python.exe -m pip freeze > packages.txt
        C:\Python%major%%minor%%patch%\python.exe -m pip install -r packages.txt --upgrade
        echo.
    ) else (
        echo.
        echo. PIP was not installed or we dont know where PIP was installed.
        echo. 
        goto end
    )

:: Run Python
:section_3
    echo.
    echo.
    del /q /f C:\Users\%USERNAME%\Downloads\packages.txt
    C:\Python%major%%minor%%patch%\python.exe -c "print(\"Python Packages updated.\")"
    C:\Python%major%%minor%%patch%\python.exe -V
    echo.
    echo.

:section_4
    echo.
    echo. 100%% Completed !
    echo.

:end