@echo off && setlocal EnableDelayedExpansion
cls
mode 40
chcp 65001 > nul
title<nul & title MONITOR SFA   By Valmir Morais
cls
echo.[?25l
echo         MONITOR DE HOST SFA
set "z=0"
set "x=1"

if not exist moni.ini (goto :hlp)

for /f "delims=" %%a in ('type moni.ini') do (
	call :uai0 "%%a"
	for /f "tokens=1,2 delims=:" %%f in ('echo %%a') do (call :uai1 "%%f" "%%g")
)

for /f %%. in ('cmd /k prompt $h$h ^<^&1') do (set "back=%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.%%.")

for /f "tokens=3 delims=." %%b in ('ver') do (set "build=%%b")
if %build% lss 18000 (set "barra=:bar18")
if %build% gtr 18000 (set "barra=:bar20")

set /a "x-=1"

set /a "linhas=(%z%*3)+%x%+11"
mode con cols=40,lines=%linhas% >nul 2>&1

:inicio

title<nul & title MONITOR SFA   By Valmir Morais

echo.
set /a "parc=100/!x!"
set /a "bar=100 - (x-1) * parc"
set /a "offl=0"
set /a "onl=0"

for /l %%q in (1,1,%x%) do (call :verif %%q)

cls
title<nul & title MONITOR SFA   By Valmir Morais
echo.
echo         MONITOR DE HOST SFA
echo.
nslookup www.r7.com 2> nul | findstr /i "Aliases:" >nul
	if errorlevel 1 (
		set "info= ║       FALHA NO LINK        ║ "
		set "_cor_=[5;97;41m"
		call :exibe
	) else (
			set "info= ║       LINK EXTERNO OK      ║ "
			set "_cor_=[97;42m"
			call :exibe
	)

set "w=1"
for /l %%n in (1,1,!z!) do (call :monte_exib %%n)

if %offl% equ 0 (set "_spceoff_= ")
if %offl% gtr 0 if %offl% lss 10 (set "_spceoff_=0")
if %offl% geq 10 (set "_spceoff_=")
if %onl% equ 0 (set "_spceon_= ")
if %onl% gtr 0 if %onl% lss 10 (set "_spceon_=0")
if %onl% geq 10 (set "_spceon_=") 
echo.
echo     [30;104m%_spceoff_%%offl%[m[37;41;3m OFFLINE[m             [30;104m%_spceon_%%onl%[m[37;42;3m ONLINE[m
ping -4 -w 1 -n 8 129.1 > nul
goto :inicio

exit
:uai1
set /a "count=0"
set "tam_esp=."

echo %~1 | findstr "[" >nul 2>&1 && (exit /b)
echo %~1 | findstr "^$" >nul 2>&1 && (exit /b) || (
	set "cond[%x%]=%~1"
	for /l %%o in (0,1,50) do (if not "!cond[%x%]:~%%o,1!" equ "" (set /a "count+=1"))
	set /a "_tam_=19-!count!"
	for /l %%d in (1,1,!_tam_!) do set "tam_esp=!tam_esp!%tam_esp%"
	set "cond[%x%]=!cond[%x%]!!tam_esp!"
	set "cond[%x%]=!cond[%x%]:~0,19!"
	@rem Array para o(s) ip(s) informado(s).
	set "ip[%x%]=%~2"
	set /a "x+=1"
	set /a "y[%z%]=%x%"
)
exit /b

:uai0

echo %~1 | findstr /i /c:"[" >nul 2>&1 && (
	set /a "z+=1"
	set "#=%~1"
	set "sub_titu[!z!]=!#:~1,-1!"
	exit /b
) || (
	exit /b
)

exit
:verif

ping !ip[%1]! -n 1 -4 -w 500 | find "TTL=" > nul && (
	set "exib[%1]=[37;1m!cond[%1]![m: [37;42;3m ONLINE[m   " && set /a onl+=1
) || (
	set "exib[%1]=[5;91;3m!cond[%1]![m: [5;37;41;3mOFFLINE[m   " && set /a offl+=1
)

set "ProgressPercent=%bar%"
set /A "NumBars=%ProgressPercent%/4"
set "Meter="
for /L %%A in (%NumBars%,-1,1) do set "Meter=!Meter!I"
@rem for /L %%A in (%NumSpaces%,-1,1) do set "Meter=!Meter!"
set /a "bar+=%parc%"
title Scan:[%Meter%]  %ProgressPercent%%% By Valmir Morais
if !ProgressPercent! lss 100 (set "sec=1")
if !ProgressPercent! geq 100 (set "sec=2")
call %barra%
ping 129.1 -4 -w 1 -n %sec% > nul
exit /b

exit
:exibe
echo.    %_cor_% ╔════════════════════════════╗ [m
echo.    %_cor_%%info%[m
echo.    %_cor_% ╚════════════════════════════╝ [m
exit /b

exit
:monte_exib
set "tam="
set "_tam_="
set "tam_esp= "
for /l %%a in (0,1,50) do (if not "!sub_titu[%1]:~%%a,1!" equ "" (set /a "tam+=1"))
set /a _tam_=(30-%tam%)/2
for /l %%d in (1,1,%_tam_%) do set tam_esp=!tam_esp!%tam_esp%
echo. 
echo   !tam_esp![90;4m!sub_titu[%1]![m!tam_esp!
echo.
for /l %%P in (%w%,1,!y[%1]!) do (call :_alin_ %%P)
set /a "w=!y[%1]!+1"
exit /b

exit
:_alin_
set "_spc_="
if %1 lss 10 (set "spc=0") else (set "spc=")
echo     !spc!%1. !exib[%1]!
exit /b

exit
:bar18
echo.    [94;104m[[!Meter!][30m!ProgressPercent!%%[m[m !back! <&1
exit /b

exit
:bar20
set /p"=[?25l[30;40;8m[[[][m[94;104m[[!Meter!][30m!ProgressPercent!%%[m[m !back!" <&1
exit /b

exit
:hlp
mode 40,5
echo.[?25l
echo    [91mERROR^^!^^^![m
echo.
echo    Aquivo moni.ini não encontrado.
echo Pressione qualquer tecla para detalhes.
pause>nul
mode 40,25
echo.
echo.
echo      [97;4mPROGRAMA DESTINADO AO SIMPLES[m
echo      [97;4mMONITORAMENTO ATRAVÉS DE PING[m
echo.
echo      Para uso se faz necessário o
echo      arquivo de configuração para
echo      carregar as informações ip do
echo      host que deseja monitorar.
echo      O arquivo deve estar na pasta 
echo      do programa e o formato será:  
echo.
echo          [93m [Título de Sessão][m
echo      [93m nome do host1:ip a monitorar[m
echo      [93m nome do host2:ip a monitorar[m
echo      [93m nome do host3:ip a monitorar[m
echo.
echo      Ex.:
echo          [33m [DEPÓSITO CENTRAL][m
echo      [33m  SERVIDOR AD:200.120.200.25[m
echo.
echo.
echo      [30;104;3m  Criado por ©Valmir Morais©  [m
echo      [30;104;3m      morvalmir@gmail.com     [m
endlocal
pause >nul
echo.[?25h
goto EOF