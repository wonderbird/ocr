@echo off
set filename=%~1
powershell -File ".\ocr.ps1" -FileName "%filename%"
