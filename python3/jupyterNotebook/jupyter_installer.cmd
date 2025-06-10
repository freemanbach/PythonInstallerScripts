@echo OFF
REM -----------------------------------------------------------------------------------
rem Auth          : Freeman
rem Email         : flo@radford.edu
rem DESC          : Install Jupyter NoteBook with Miniconda (Windows)
rem 32bit path    : https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe
rem 64bit path    : https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
rem Date          : 20250609
REM -----------------------------------------------------------------------------------

::set badmin32=C:\Windows\System32\bitsadmin.exe
::set badmin64=C:\Windows\SysWOW64\bitsadmin.exe

set mc32=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe
set mc64=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe

:: checking and saving the location of Bits-admin
:: made detecting bitsadmin at run-time
for /f %%i in ('where bitsadmin') do (
    set badmin=%%i
)
if /i %badmin%=="" (
    echo. There is no bitsadmin.
    echo. Contact your Professor Hobbit.
    echo.
    goto end
)

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
    timeout /t 2 > nul
    rem Switch to Downloads early on
    cd %~dp0
    echo. 5%% Completed.

:time_pause2
    timeout /t 2 > nul

:: Section 4: Bitsadmin Download.
:section_1
    echo. ============================
    echo. Checking Bitsadmin
    echo. ============================
    echo.
    REM forgot that 32bit Windows has a different location for bitsadmin
    if /i "%processor_architecture%"=="arm64" (
        rem check location of BitsAdmin
        if exist %badmin% (
            echo. Bitsadmin 64bit is installed on your Windows 10/11 system.
            echo. Will download Python 3 software.
            echo.
            goto section_1_1
        ) else (
            echo. We dont know where bitsadmin 64bit is located.
            echo. line 85
            goto end
        )
    ) 
    
    if /i "%processor_architecture%"=="amd64" (
        rem check location of BitsAdmin
        if exist %badmin% (
            echo. Bitsadmin 64bit for ARM and AMD is installed on your Windows 10/11 system.
            echo. Will download Python 3 software.
            echo.
            goto section_1_1
        ) else (
            echo. We dont know where bitsadmin 64bit is located.
            echo. line 99
            goto end
        )
    )           

    if /i "%processor_architecture%"=="x86" (
        rem check location of BitsAdmin
        if exist %badmin% (
            echo. Bitsadmin 32bit is installed on your Windows 10/11 system.
            echo. Will download Python 3 software.
            echo.
            goto section_1_1
        ) else (
            echo. We dont know where bitsadmin 64bit is located.
            echo. line 113
            goto end
        )
    )

:section_1_1
    echo.          
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
    if /i "%processor_architecture%"=="arm64" (
            rem Run 64bit downloader even when its ARM processor just run x86_64 installer
            %badmin% /transfer PythonDownload /download /priority normal %mc64% %~dp0Miniconda3-latest-Windows-x86_64.exe
        ) 
    if /i "%processor_architecture%"=="amd64" (
            rem Run 64bit downloader
            %badmin% /transfer PythonDownload /download /priority normal %mc64% %~dp0Miniconda3-latest-Windows-x86_64.exe
        )
    if /i "%processor_architecture%"=="x86" (
            rem Run 32bit downloader
            %badmin% /transfer PythonDownload /download /priority normal %mc32% %~dp0Miniconda3-latest-Windows-x86.exe
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
            goto section_3_1
        ) else (
            echo. Software not found.
            echo. Perhaps, try to run this file again.
            echo. line 164
            echo.
            goto end
        )
    ) else (
        if exist Miniconda3-latest-Windows-x86_64.exe (
            echo. MiniConda executable has been Found.
            echo. Will now Install this Software.
            echo.
            goto section_3_1
        ) else (
            echo. Software not found.
            echo. Perhaps, try to run this file again.
            echo. line 145
            echo.
            goto end
        )
    )

:section_3_1
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
         %~dp0Miniconda3-latest-Windows-x86.exe
        timeout /t 2 > nul
    ) else (
         %~dp0Miniconda3-latest-Windows-x86_64.exe
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
            echo. MiniConda Software has been Installed.
            echo.
        ) else (
            echo.
            echo. MiniConda has not been installed.
            echo. Problem with installation. 
            echo. line 226
            goto end
        )
    ) else (
        echo.
        echo. MiniConda has not been installed.
        echo. Problem with installation. 
        echo. line 225
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
    set num=15
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

:section_8_1
    setlocal
    echo.
    echo. =======================================
    echo. Creating a Jupyter Notebook Folder
    echo. =======================================
    echo.
    mkdir C:\Users\%USERNAME%\jupyter_projects
    timeout /t 1 > nul

:time_pause2
    echo.
    timeout /t 2 > nul

:section_9
    setlocal
    echo.
    echo. =======================================
    echo. launching Jupyter Notebook
    echo. =======================================
    echo.
    echo. launching Jupyter Notebook
    echo.
    cd C:\Users\%USERNAME%\jupyter_projects
    REM call the native jupyter notebook via miniconda binary instead of my 
    REM native python installation of jupyter-notebook.
    C:\users\%USERNAME%\miniconda3\Scripts\jupyter-notebook.exe
    
:end