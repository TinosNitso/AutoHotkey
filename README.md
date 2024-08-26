# AutoHotkey
- [Installation](#installation)
- [App Versions](#app-versions)

For Windows/Linux dvorak users! Built for Windows (ahk-v2), Linux (v1.0) & Windows XP (v1.1).  There's RWIN for LockWorkStation, !r rename, !e explorer, !d duplicate, !^+d dvorak toggle, ^t transparency toggle, ^SPACE AlwaysOnTop, ^!SPACE suspend/pause, F12 TitleBar toggle, ^F12 grip toggle, F11 window-list & ^F11 for ControlList.  The linux version is missing most of that (see tray menu).  

These scripts emulate CTRL with ALT, so copy/paste can be done with left thumb. My left pinky broke @school when I was young.

![](doc/Screenshot64.png "v2") ![](doc/ScreenshotU32.png "v1.1") 

## Installation
- On Windows use either `AutoHotkey64.ahk` or `AutoHotkey64.exe`.  The system keyboard should be QWERTY.  App is 1MiB.  AHK easily maps dvorak all by itself.
- On Windows XP use either `AutoHotkeyU32.ahk` or `AutoHotkeyU32.exe`.  App is 1MiB.
- On Linux use either `ahk_x11.ahk` or `ahk_x11.AppImage`.  The system keyboard should be dvorak.  App is 33MiB.

All builds are easily reproducible. To use the scripts requires putting them alongside the official executable & double-clicking on it (`AutoHotkey64.exe`). 

Also create a **shortcut** on the desktop to the executable. Right-click→Send to→Desktop. 

To use as admin in Windows 10, right-click on the shortcut→Properties→Compatibility→Run this program as an administrator→OK.

- To boot with Windows 10, copy the shortcut to hidden folder: `C:\Users\username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs`. I created a library for it, & I also moved my Roaming folder to a different drive.
- To boot with Windows XP, drag & drop shortcut onto start→All Programs→Startup.  It's the easiest!
- To boot with Linux, configure System→Preferences→Personal→Startup Applications→Add→Browse→ahk_x11.AppImage→Open.

## App Versions
- AutoHotkey64 is for v2.0.18.
- AutoHotkeyU32 is for v1.1.37.  Simpler script than v2.
- ahk_x11 is for v1.0.4.  Simplest script.

