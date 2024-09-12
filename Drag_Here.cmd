@echo off
setlocal enabledelayedexpansion

:: This file is part of sygil-webui (https://github.com/Sygil-Dev/sygil-webui/).
:: 
:: Copyright 2022 Sygil-Dev team.
:: This program is free software: you can redistribute it and/or modify
:: it under the terms of the GNU Affero General Public License as published by
:: the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
:: 
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU Affero General Public License for more details.
:: 
:: You should have received a copy of the GNU Affero General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>. 

:: Run all commands using this script's directory as the working directory
cd %~dp0

:: Set the conda environment name
set v_conda_env_name=ozen
echo Environment name is set as %v_conda_env_name%

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

:: Activate the conda environment
echo Activating conda environment: %v_conda_env_name%
call "%v_conda_path%\Scripts\activate.bat" "%v_conda_env_name%"
if %errorlevel% neq 0 (
    echo Failed to activate Conda environment. Error level: %errorlevel%
    echo Make sure the environment "%v_conda_env_name%" exists.
    echo You may need to create it first using the setup script.
    pause
    exit /b 1
)

echo Conda environment activated successfully

:START_GUI
echo Starting Ozen GUI...
python ozen.py "%~1"
if %errorlevel% neq 0 (
    echo Failed to start Ozen GUI. Error level: %errorlevel%
    pause
    exit /b 1
)

echo Ozen GUI has closed. Press any key to exit.
pause
