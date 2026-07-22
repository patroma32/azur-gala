@echo off
chcp 65001 >nul
title Publier le dossier Gala en ligne
cd /d "%~dp0"

echo.
echo ========================================================
echo    PUBLICATION DU DOSSIER GALA (AZUR)
echo ========================================================
echo.

echo  [1/2] Sauvegarde de securite sur GitHub...
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Mise a jour du %date% %time%" >nul
    git push
    echo        Sauvegarde effectuee.
) else (
    echo        Rien de nouveau a sauvegarder.
)

echo.
echo  [2/2] Mise en ligne du site (Vercel)... merci de patienter.
call npx --yes vercel --prod --yes

if errorlevel 1 (
    echo.
    echo  ========================================================
    echo    PROBLEME lors de la mise en ligne.
    echo    Notez le message ci-dessus et prevenez Claude.
    echo  ========================================================
) else (
    echo.
    echo  ========================================================
    echo    C'EST EN LIGNE !
    echo    Site : azur-gala.vercel.app
    echo    Pensez a faire Ctrl+F5 pour voir la nouvelle version.
    echo  ========================================================
)

echo.
pause
