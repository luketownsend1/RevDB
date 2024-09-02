@echo off
title RevDB
color 7
setlocal enabledelayedexpansion

:mainmenu
echo -Quick Menu-
echo.
adb devices
echo.
echo C)		Quick Connect (192.168.43.1)
echo D)		Disconnect
echo I)		Connect to custom IP
echo R)     Refresh device listing
echo X)		Close
echo.
set /p letter=:
set address=NoAddressSet

rem Converts letter to lowercase
set "letter=!letter:~0,1!"
for %%A in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    set "letter=!letter:%%A=%%A!"
)

if /i "%letter%"=="x" (
    exit

) else (if /i "%letter%"=="i" (
    goto executeIP

)) else (if /i "%letter%"=="d" (
    cls
    adb disconnect
    echo.
    goto mainmenu

)) else (if /i "%letter%"=="c" (
    cls
    echo Attempting Connection...
    adb connect 192.168.43.1
    echo.
    goto mainmenu

)) else (if /i "%letter%"=="r" (
    cls
    color 6
    echo Devices Refreshed.
    color 7
    echo.
    goto mainmenu

)) else (
    cls
    color 4
    echo Invalid Input. Try Again.
    color 7
    echo.
    goto mainmenu

)

rem 						CUSTOM IP FUNCTION
:executeIP
echo -Custom IP Menu-
echo.
adb devices
echo.
echo Please enter your desired IP address.
echo.
echo Extra Controls:
echo D)     Disconnect
echo R)     Refresh device listing
echo X)     Quit
echo.
set /p address=:

rem Converts address to lowercase
set "address=!address:~0,1!"
for %%A in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    set "address=!address:%%A=%%A!"
)

if /i "%address%"=="x" (
    cls
    goto mainmenu

) else (if /i "%address%"=="d" (
    cls
    color 6
    adb disconnect
    color 7
    echo.
    goto executeIP

)) else (if /i "%address%"=="r" (
    cls
    color 6
    echo Devices Refreshed
    color 7
    echo.
    goto executeIP

)) else (
    cls
    color 6
    echo Attempting connection to %address%...
    color 5
    adb connect %address%
    color 7
    echo.
    goto executeIP

)
