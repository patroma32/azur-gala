@echo off
chcp 65001 >nul
title Publier le dossier Gala en ligne
cd /d "%~dp0"

echo.
echo ========================================================
echo    PUBLICATION DU DOSSIER GALA (AZUR)
echo ========================================================
echo.
echo  Je regarde ce qui a change...
echo.

git add -A

REM S'il n'y a rien de nouveau, on s'arrete proprement
git diff --cached --quiet
if %errorlevel%==0 (
    echo  Aucune modification a publier : le site est deja a jour.
    echo.
    pause
    exit /b 0
)

echo  Modifications detectees. Enregistrement...
git commit -m "Mise a jour du %date% %time%" >nul

echo  Envoi vers GitHub / Vercel...
git push

if %errorlevel%==0 (
    echo.
    echo  ========================================================
    echo    C'EST PUBLIE !
    echo    Le site se met a jour tout seul dans 1 a 2 minutes.
    echo  ========================================================
) else (
    echo.
    echo  ========================================================
    echo    PROBLEME lors de l'envoi.
    echo    Notez le message ci-dessus et prevenez Claude.
    echo  ========================================================
)

echo.
pause
