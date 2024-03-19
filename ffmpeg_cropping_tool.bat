::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSTk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAjk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

REM Prompt for input file path
set /p input_path=Enter the input file path: 

REM Prompt for output file name (including extension)
set /p output_path=Enter the output file path: 

REM Prompt for start time (format: hh:mm:ss.ms)
set /p start_time=Enter the start time (e.g., 00:06:20.112): 

REM Prompt for end time (format: hh:mm:ss.ms)
set /p end_time=Enter the end time (e.g., 00:06:30.000): 

REM Prompt for video CODEC (Matching file extension) 
set /p video_codec_input=Enter video codec (e.g., h264_nvenc; h264; vp9; av01;... Leave empty to let FFmpeg choose)

set /p video_preset_input=Enter video preset (leave empty to let FFmpeg choose): 

REM If there's no input, does not include -c:v in the command itself
REM If there's no preset input, does not include -preset in the command itself
if "%video_codec_input%" == "" set video_codec=^@
if "%video_codec_input%" neq "" set video_codec=-c:v %video_codec_input%

if "%video_preset_input%" == "" set video_preset=^@
if "%video_preset_input%" neq "" set video_preset=-preset %video_preset_input%

REM Prompt for video bitrate (default: 16000k)
set /p video_bitrate=Enter the video bitrate (default: 16000k): 
if "%video_bitrate%" == "" set "video_bitrate=16000k"

REM Prompt for audio bitrate (default: 320k)
set /p audio_bitrate=Enter the audio bitrate (default: 320k): 
if "%audio_bitrate%" == "" set "audio_bitrate=320k"

REM Construct the FFmpeg command
set ffmpeg_cmd=ffmpeg -ss %start_time% -to %end_time% -i !input_path! %video_codec% %video_preset% -b:v %video_bitrate% -b:a %audio_bitrate% !output_path!

REM Display the FFmpeg command
echo The following command will be executed:
echo !ffmpeg_cmd!

REM Save the FFmpeg command to a temporary batch file
echo !ffmpeg_cmd! > temp_ffmpeg_command.bat

REM Execute the temporary batch file in an external Command Prompt window
start cmd /c temp_ffmpeg_command.bat

pause

REM Delete the temporary batch file
del temp_ffmpeg_command.bat

REM Rerun Batch file after completion
start cmd /c ffmpeg_cropping_tool.exe
