@echo OFF

REM Auth          : Freeman
REM Email         : flo@radford.edu
REM DESC          : Install Jupyter NoteBook with Miniconda (Windows)
REM 32bit path    : https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe
REM 64bit path    : https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
REM Date          : 2023.09.04

set badmin32=C:\Windows\System32\bitsadmin.exe
set badmin64=C:\Windows\SysWOW64\bitsadmin.exe

set mc32=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe
set mc64=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe


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
    echo. 1%% Completed.

:time_pause2
    echo.
    timeout /t 2 > nul

:: clear screen
cls

:: Prompt
:start_this
    setlocal
    echo.
    echo. ** We recommend installing this software for your personal User ONLY instead of --Everyone--. **
    echo. ** This Installation of MiniConda and Jupyter Notebook will only work for --USER-- ONLY !!!   **
    echo.
    set _value="n"
    set /p _value=Are you sure installing MiniConda x86-64 or x86 (y/[n]) ?
    if /i "%_value%" NEQ "y" goto end

:: 
:section_0
    setlocal
    title Installing MiniConda
    timeout /t 1 > nul
    rem Switch to Downloads early on
    cd C:\Users\%USERNAME%\Downloads
    echo. 5%% Completed.

:time_pause2
    timeout /t 2 > nul

:: Section 4: Bitsadmin Download.
:section_1
    setlocal
    echo.
    echo. ============================
    echo. Checking Bitsadmin
    echo. ============================
    echo.

    REM forgot that 32bit Windows has a different location for bitsadmin
    if /i "%processor_architecture%"=="x86" (
        rem check 32bit FTP downloader
        if exist %badmin32% (
            echo. Bitsadmin 32bit is installed on your Windows 7/8/9/10/11 system.
            echo. Will download MiniConda 
            echo.
            goto section_2
        ) else (
            echo. We dont know where bitsadmin 32bit is located.
            echo. line 74
            goto end
        )
    ) else (
        rem check 64bit FTP downloader
        if exist %badmin64% (
            echo. Bitsadmin 64bit is installed on your Windows 7/8/9/10/11 system.
            echo. Will download MiniConda 
            echo.
            goto section_2
        ) else (
            echo. We dont know where bitsadmin 64bit is located.
            echo. line 88
            goto end
        )
    )           
    echo. 15%% Completed.

:: Section 5: Python Download.
:section_2
    echo.
    echo. ============================
    echo. Downloading MiniConda
    echo. ============================
    echo.

:: Section 5: Python Download.
:check_arch
    echo.
    if /i "%processor_architecture%"=="x86" (
            rem Run 32bit downloader
            %badmin32% /transfer MiniCondaDownload /download /priority normal %mc32% C:\Users\%USERNAME%\Downloads\Miniconda3-latest-Windows-x86.exe
        ) else (
            rem Run 64bit downloader
            %badmin64% /transfer MiniCondaDownload /download /priority normal %mc64% C:\Users\%USERNAME%\Downloads\Miniconda3-latest-Windows-x86_64.exe
        )           
    echo.  25%% Completed.
    echo.

:time_pause2
    echo.
    timeout /t 2 > nul

:: Checking to see if miniconda
:section_3
    echo.
    echo. Checking to see if miniconda has been downloaded.
    rem Kept forgetting that there are two architectures
    if /i "%processor_architecture%"=="x86" (
        if exist Miniconda3-latest-Windows-x86.exe (
            echo. MiniConda executable has been Found.
            echo. Will now Install this Software.
            echo.
            goto section_4
        ) else (
            echo. Software not found.
            echo. Perhaps, try to run this file again.
            echo. line 132
            echo.
            goto end
        )
    ) else (
        if exist Miniconda3-latest-Windows-x86_64.exe (
            echo. MiniConda executable has been Found.
            echo. Will now Install this Software.
            echo.
            goto section_4
        ) else (
            echo. Software not found.
            echo. Perhaps, try to run this file again.
            echo. line 145
            echo.
            goto end
        )
    )
    echo.  35%% Completed.
    echo.

:: Finish downloading the MiniConda Software
:section_4
    echo.
    rem nothing to see here
    timeout /t 2 > nul

:: Installing MiniConda
:section_5
    echo.
    echo. ============================
    echo. Installing MiniConda
    echo. ============================
    echo.
    echo. Go grab Koffee or something, installion will take sometime.
    if /i "%processor_architecture%"=="x86" (
        C:\Users\%USERNAME%\Downloads\Miniconda3-latest-Windows-x86.exe
        timeout /t 2 > nul
    ) else (
        C:\Users\%USERNAME%\Downloads\Miniconda3-latest-Windows-x86_64.exe
        timeout /t 2 > nul
    )
    echo. 45%% Completed.

:time_pause2
    echo.
    timeout /t 2 > nul

:: Check to see if MiniConda was installed 
:section_5_1
    echo.
    if exist C:\Users\%USERNAME%\miniconda3\_conda.exe (
        if exist C:\Users\%USERNAME%\miniconda3\condabin\activate.bat (
            echo.
            echo. Checking whether MiniConda has been installed...
            echo.
            echo. MiniConda Software has been Installed.
            echo.
        ) else (
            echo.
            echo. MiniConda has not been installed.
            echo.
            echo. Problem with installation. 
            echo. line 192
            goto end
        )
    ) else (
        echo.
        echo. MiniConda has not been installed.
        echo.
        echo. Problem with installation. 
        echo. line 191
        echo.
        goto end
    )
    echo. 55%% Completed.
    echo.

:: spinning it for a minute
:section_6
    setlocal
    echo.
    echo. =======================================
    echo. Compiling Miniconda Modules
    echo. =======================================
    echo.
    set num=20
    for /L %%I IN (1, 1, %num%) do (
        echo. | set /p="%%I " 
        timeout /t 1 > nul
    )
    echo. 65%% Completed.

:time_pause5
    echo.
    timeout /t 5 > nul

:section_7
    setlocal
    echo.
    echo. =======================================
    echo. Updating MiniConda Packages
    echo. =======================================
    echo.
    C:\Users\%USERNAME%\miniconda3\condabin\conda.bat update -n base -c defaults conda
    timeout /t 3 > nul
    echo. 85%% completed.

:time_pause2
    echo.
    timeout /t 2 > nul

:section_8
    setlocal
    echo.
    echo. =======================================
    echo. Installing Jupyter Notebook
    echo. =======================================
    echo.
    C:\Users\%USERNAME%\miniconda3\condabin\conda.bat install -c conda-forge notebook
    timeout /t 3 > nul
    echo. 100%% completed.

:time_pause2
    echo.
    timeout /t 3 > nul

:section_9
    setlocal
    echo.
    echo. =======================================
    echo. launching Jupyter Notebook
    echo. =======================================
    echo.
    echo. launching Jupyter Notebook
    echo.
    jupyter notebook
    
:end