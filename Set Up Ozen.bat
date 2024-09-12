@echo off
setlocal enabledelayedexpansion

:: This file is part of sygil-webui (https://github.com/Sygil-Dev/sygil-webui/).

:: Run all commands using this script's directory as the working directory
cd %~dp0

:: Copy over the first line from environment.yaml, e.g. name: ldm, and take the second word after splitting by ":" delimiter
for /F "tokens=2 delims=: " %%i in (environment.yaml) DO (
  set v_conda_env_name=%%i
  goto EOL
)
:EOL
echo Environment name is set as %v_conda_env_name% as per environment.yaml

:: ***Set the path to your Miniconda3 installation
set v_conda_path=C:\miniconda3

:: Check if the Miniconda3 directory exists
if not exist "%v_conda_path%" (
    echo Miniconda3 not found at %v_conda_path%
    echo Please ensure Miniconda3 is installed at this location or modify the script with the correct path.
    pause
    exit /b 1
)

echo Found Miniconda3 at %v_conda_path%

:: Activate the base Conda environment
call "%v_conda_path%\Scripts\activate.bat"
if %errorlevel% neq 0 (
    echo Failed to activate Conda. Error level: %errorlevel%
    pause
    exit /b 1
)

echo Conda activated successfully

:: Create the conda environment
echo Creating conda environment: %v_conda_env_name%
call conda env create --name "%v_conda_env_name%" -f environment.yaml
if %errorlevel% neq 0 (
    echo Failed to create Conda environment. Error level: %errorlevel%
    pause
    exit /b 1
)

:: Activate the newly created environment
echo Activating conda environment: %v_conda_env_name%
call conda activate "%v_conda_env_name%"
if %errorlevel% neq 0 (
    echo Failed to activate Conda environment. Error level: %errorlevel%
    pause
    exit /b 1
)

echo Conda environment activated successfully

:PROMPT
echo Script completed successfully
pause
