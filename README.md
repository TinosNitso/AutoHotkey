# AutoHotkey
- [Intro](#intro)
- [Installation](#installation)
- [Startup @Boot](#startup-boot)
- [Versions](#versions)
- [Reproducibility](#reproducibility)
- [Latest Updates](#latest-updates)

## Intro
For Windows/Linux dvorak users! Compiled for Windows (ahk-v2), Linux/Win98 (v1.0) & Windows XP (v1.1).  The linux version is missing some of these (see tray menus).  

- Duplicate `^d`
- Toggle dvorak `^!+d`
- Toggle transparency `#t`
- Toggle AlwaysOnTop `#SPACE`
- Suspend `^!SPACE`
- Toggle TitleBar `F12`
- Toggle grip `^F12`
- Window-list `F11`
- Hidden-window-list `+F11`
- ControlList `^F11`
- Rename `!r`
- Explorer `!e`.  

These scripts emulate CTRL with ALT, so copy/paste can be done with left thumb. My left pinky is a bit awkward - it broke @school when I was young.

![](SCREENSHOTS.png)

## Installation
- On Windows use either `AutoHotkey64.ahk` or `AutoHotkey64.exe`.  App is 1.2 MiB. OS keyboard should be QWERTY.  AHK easily maps dvorak all by itself. Official releases are [here][official_v2].
- On Windows XP use either `AutoHotkeyU32.ahk` or `AutoHotkeyU32.exe`.  App is .9 MiB.  OS keyboard should be QWERTY.  Official releases (with compiler) are [here][official_v1.1].
- On Win98 use either `AutoHotkey.ahk` or `AutoHotkey.exe`.  App is .4 MiB.  OS keyboard should be dvorak.  Official releases (with compiler) are [here][official_v1.0].
- On Linux use either `ahk_x11.ahk` or `ahk_x11.AppImage`.  App is 33MiB. OS keyboard should be dvorak.  If it doesn't run, grant it the allow executing the file as program permission.  Official `ahk_x11.AppImage` is [here][official_x11].

To use the scripts directly requires putting them alongside the [official](https://autohotkey.com) executables & double-clicking on them.

Also create a shortcut on the desktop to the executable. Right-click→Send to→Desktop. 

To use as admin in Windows 10, right-click on the shortcut→Properties→Compatibility→Run this program as an administrator→OK.

For script coloring, copy [userDefineLang_AHK.xml](doc/userDefineLang_AHK.xml) into [Notepad++](https://notepad-plus-plus.org) folder `userDefineLangs`. Then restart npp & select Language→AutoHotkey. The .ahk scripts are all written to be colorful in this theme. I use npp portable. I adjusted the .xml from [AutoHotKey-NotepadPlusPlus-Integration][ahk_npp].  AHK could implement some scintilla commands, like duplicate, in other apps.  In Win98 use [v6.0-ansi][npp_rep].

## Startup @Boot
- To boot with Windows 10, copy the shortcut to hidden folder: `C:\Users\username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs`. I created a library for it, & I also moved my Roaming folder to a different drive.
- To boot with Windows XP, drag & drop shortcut onto start→All Programs→Startup.  It's the easiest!
- Windows 98 similar to XP. Drag shortcut onto Start→Programs→StartUp.
- To boot with Linux, configure System→Preferences→Personal→Startup Applications→Add→Browse→ahk_x11.AppImage→Open.

## Versions
AHKVersion is visible in all tray icon tips. See [SCREENSHOTS](SCREENSHOTS.png).
- `AutoHotkey64.ahk` is for v2.0.18.
- `AutoHotkeyU32.ahk` is for v1.1.37.02.  Simpler script than v2.
- `AutoHotkey.ahk` is for v1.0.48.05, from 2009!  Simplest script.
- `ahk_x11.ahk` (based on 1.0.4) is from v1.0.24, from 2004!

## Reproducibility
- `AutoHotkey64.exe` (v2) is data-reproducible (1.2 MiB). Use [7-Zip](https://7-zip.org) to extract everything into a new folder, then verify that folder's SHA-256 matches that of any other compilation's extraction.
- `AutoHotkeyU32.exe` (v1.1) is data-reproducible (.9 MiB). Uses the same compiler as v2. The compiler reports itself along with the entire stripped script in `\.rsrc\RCDATA\1`.  Right-click the .exe→7-Zip→Open Archive, then right-click→View the `1` file, located in .resources\RESOURCE COMPILER DATA. 
- `AutoHotkey.exe` (v1.0) is not reproducible. It uses an old compiler, set to Lowest Compression.
- `ahk_x11.AppImage` is data-reproducible (103 MiB).  Re-compile it using Phil's official compiler, & then check the SHA-256 of a full data extraction matches.

The compilers put unique metadata bytecode into the .exe/.AppImage, which is separate to the data contained within the executables. Sometimes it reproduces the same metadata, sometimes not.

## Latest Updates
- Win98 now supported.
- Updated [doc](doc) with `.chm` & `.pdf` help files, along with `.xml` npp integration.
- Added script-options TRANSPARENT, NPP & EXPLORERS (initial lines).
- `+F11` now gives 2 indexed popups, full process list followed by full class list.  `^F11` HWND bugfix.
- Linux proper transparency toggle.  Redo bugfix `^*COLON`. Improved duplicate `^d` & `F11`.
- Improved `!LBUTTON` reliability.
- Removed LockWorkStation `RWIN`.  Too annoying!
- Improved directives layout.  Simplified logic for functions.

[official_v2]: https://github.com/AutoHotkey/AutoHotkey/releases
[official_v1.1]: https://autohotkey.com/download/1.1
[official_v1.0]: https://autohotkey.com/download/1.0
[official_x11]: https://github.com/phil294/AHK_X11/releases
[ahk_npp]: https://github.com/k4gdw/AutoHotKey-NotepadPlusPlus-Integration
[npp_rep]: http://download.notepad-plus-plus.org/repository/

