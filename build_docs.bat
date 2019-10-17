@echo off
rem batch file written by Louka
rem must have lua51 in your %PATH%
where lua51 >nul 2>nul
if errorlevel 0 (
	echo build_docs - building documentation
	cd docs
	del /s /q "*.*" >nul
	cd ..
	lua51 docgenx.lua docapi.lua
) else (
	echo build_docs - please install lua51 into your path before using build_docs
)
pause