# AutoHotkey
- [Installation](#installation)
- [Startup @Boot](#startup-boot)
- [Versions](#versions)
- [Reproducibility](#reproducibility)
- [Latest Updates](#latest-updates)

For Windows/Linux dvorak users! Built for Windows (ahk-v2), Linux (v1.0) & Windows XP (v1.1).  There's LockWorkStation `RWIN`, transparency toggle `#t`, rename `!r`, explorer `!e`, duplicate `!d`, Dvorak toggle `^!+d`, AlwaysOnTop toggle `#SPACE`, suspend/pause toggle `^!SPACE`, TitleBar toggle `F12`, grip toggle `^F12`, window-list `F11` & ControlList `^F11`.  The linux version is missing some of that (see tray menus).  

![](SCREENSHOTS.png)

These scripts emulate CTRL with ALT, so copy/paste can be done with left thumb. My left pinky is a bit awkward - it broke @school when I was young.

## Installation
- On Windows use either `AutoHotkey64.ahk` or `AutoHotkey64.exe`.  The system keyboard should be QWERTY.  App is 1MiB.  AHK easily maps dvorak all by itself. Official releases are [here](https://github.com/AutoHotkey/AutoHotkey/releases).
- On Windows XP use either `AutoHotkeyU32.ahk` or `AutoHotkeyU32.exe`.  App is 1MiB.  Official releases (with compiler) are [here](https://autohotkey.com/download/1.1/).
- On Linux use either `ahk_x11.ahk` or `ahk_x11.AppImage`.  The system keyboard should be dvorak.  App is 33MiB. If it doesn't run, grant it the allow executing the file as program permission.  Official `ahk_x11.AppImage` is [here](https://github.com/phil294/AHK_X11/releases).

To use the scripts directly requires putting them alongside the [official](https://autohotkey.com) executables & double-clicking on them.

Also create a shortcut on the desktop to the executable. Right-click→Send to→Desktop. 

To use as admin in Windows 10, right-click on the shortcut→Properties→Compatibility→Run this program as an administrator→OK.

For script coloring, copy [userDefineLang_AHK.xml](doc/userDefineLang_AHK.xml) into Notepad++ folder `userDefineLangs`. The .ahk scripts are all written to be colorful in this theme. Variable names are special, etc.  I use npp portable. I copied the xml from somewhere else.

## Startup @Boot
- To boot with Windows 10, copy the shortcut to hidden folder: `C:\Users\username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs`. I created a library for it, & I also moved my Roaming folder to a different drive.
- To boot with Windows XP, drag & drop shortcut onto start→All Programs→Startup.  It's the easiest!
- To boot with Linux, configure System→Preferences→Personal→Startup Applications→Add→Browse→ahk_x11.AppImage→Open.

## Versions
AHKVersion is visible in all tray icon tips. See [SCREENSHOTS](SCREENSHOTS.png).
- AutoHotkey64 is for v2.0.18.
- AutoHotkeyU32 is for v1.1.37.02.  Simpler script than v2.
- ahk_x11-1.0.4 is from v1.0.24, from 2004!  Simplest script.

## Reproducibility
- To check `AutoHotkey64.exe` use 7-Zip to extract everything into a new folder, then verify that folder's SHA-256 matches your own build's extraction.  The compiler puts unique metadata bytecode into the .exe, which is completely separate to all data contained within it. Sometimes it reproduces the same metadata, sometimes not.
- `AutoHotkeyU32.exe` (v1.1) uses same compiler as v2. The compiler reports itself along with the entire stripped script in `\.rsrc\RCDATA\1`.  Right-click the .exe→7-Zip→Open Archive, then right-click→View the `1` file, located in .resources\RESOURCE COMPILER DATA. 
- To check `ahk_x11.AppImage` re-compile it using Phil's official compiler, & then check the SHA-256 matches.

## Latest Updates
- `F11` & `+F11` window-lists for Linux.
- Improved window-lists & improved reliability.
- Added duplicate to all tray menus. 
- Pause removed from `^!SPACE` toggle.
- #t & #SPACE win-ops (transparency & AlwaysOnTop). 

