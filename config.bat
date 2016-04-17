@ECHO OFF
REM this is a DOS batch file

REM *vital* This is the path to the perl interpreter
set PERL=perl

REM -------------------------------------------------------------------------
ECHO Starting Configuration...

IF EXIST cfgcache.pm DEL cfgcache.pm
%PERL% config\config.pl PERL=%PERL% %1 %2 %3 %4 %5 %6 %7 %8 %9
IF NOT EXIST cfgcache.pm GOTO ERROR

REM -------------------------------------------------------------------------
ECHO Starting build...

ECHO ... building latex2html
%PERL% config\build.pl -x latex2html
IF ERRORLEVEL 1 GOTO ERROR

ECHO ... building pstoimg
%PERL% config\build.pl -x pstoimg
IF ERRORLEVEL 1 GOTO ERROR

ECHO ... building texexpand
%PERL% config\build.pl -x texexpand
IF ERRORLEVEL 1 GOTO ERROR

ECHO ... building configuration module
%PERL% config\build.pl l2hconf.pm
IF ERRORLEVEL 1 GOTO ERROR

GOTO OK

REM -------------------------------------------------------------------------
:ERROR
ECHO An error has occured, aborting

REM -------------------------------------------------------------------------
:OK
ECHO Configuration procedure finished
:END

