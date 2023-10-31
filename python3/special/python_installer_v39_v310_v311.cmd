@echo OFF
REM -----------------------------------------------------------------------------------
REM Auth          : Freeman
REM Email         : flo@radford.edu
REM DESC          : Silent Python Installer for Windows
REM 32bit path    : 
REM 64bit path    : 
REM Date          : 2023.10.21
REM -----------------------------------------------------------------------------------

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
    echo.
    timeout /t 3 > nul

:check_bitsadmin
    REM forgot that 32bit Windows has a different location for bitsadmin
    if /i "%processor_architecture%"=="x86" (
        rem check 32bit FTP downloader
        if exist %badmin32% (
            echo. Bitsadmin 32bit is installed on your Windows 10/11 system.
            echo.
            goto clear_me
        ) else (
            echo. We dont know where bitsadmin 32bit is located.
            echo. line 38
            goto end
        )
    ) else (
        rem check 64bit FTP downloader
        if exist %badmin64% (
            echo. Bitsadmin 64bit is installed on your Windows 10/11 system.
            echo.
            goto clear_me
        ) else (
            echo. We dont know where bitsadmin 64bit is located.
            echo. line 49
            goto end
        )
    )           

:time_pause2
    echo.
    timeout /t 3 > nul

:: clear screen
:clear_me
    cls

:: Prompt for user to Really run this script
:start_this
    setlocal
    set param="n"
    set /p param=Are you sure installing Python x86-64 or x86 (y/[n]) ?
    if /i "%param%" NEQ "y" goto end
    
:time_pause2
    echo.
    timeout /t 3 > nul

:: Choose the version of python
:choose_python_version
    setlocal
    REM Installing the most recent python verion
    set _version_=11
    cls
    echo.
    echo. Choose: 3.9.x or 3.10.x or 3.11.x
    echo.
    set /p _version_=Which Python versions do you like to install (9/10/[11]) ?
    set /a _version_="%_version_%"*1
    echo.
    if %_version_% gtr 0 (
        if %_version_% == 9 (
            REM user want to install install python 3.9.x
            echo. Will install Python 3.9 
            goto python39
        )

        if %_version_% == 10 (
            REM user want to install install python 3.10.x
            echo. Will install Python 3.10
            goto python310
        )

        if %_version_% == 11 (
            REM user want to install install python 3.11.x
            echo. Will install Python 3.11
            goto python311
        )
    ) else (
        echo. Not a Number, exiting....
        goto end
    )
    if "%_version_%"=="" goto end
    echo.
    echo.

:: Download Python 3.9.x install script
:python39
    setlocal   
    set major=3
    set minor=9
    set patch=12
    echo.
    if /i "%processor_architecture%"=="x86" (
            rem Run 32bit downloader
            %badmin32% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python39/3.9.12/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        ) else (
            rem Run 64bit downloader
            %badmin64% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python39/3.9.12/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        )
    echo.

:: Download Python 3.10.x install script
:python310
    setlocal
    set major=3
    set minor=10
    set patch=11
    echo.
    if /i "%processor_architecture%"=="x86" (
            rem Run 32bit downloader
            %badmin32% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python310/3.10.11/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        ) else (
            rem Run 64bit downloader
            %badmin64% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python310/3.10.11/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        )
    echo.

:: Install Python 3.11.x
:python311
    setlocal
    set major=3
    set minor=11
    set patch=6
    if /i "%processor_architecture%"=="x86" (
            rem Run 32bit downloader
            %badmin32% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python311/3.11.6/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd            
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        ) else (
            rem Run 64bit downloader
            %badmin64% /transfer PythonDownload /download /priority normal https://raw.githubusercontent.com/freemanbach/PythonInstallerScripts/main/python3/python311/3.11.6/pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            echo.
            timeout /t 4 > nul
            call C:\Users\%USERNAME%\Downloads\pythonV%major%%minor%%patch%_cs_mu_ns_win.cmd
            goto end
        )
    echo.
:end