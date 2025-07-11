# Clipboarder

Clipboarder is a very simple tool that re-formats certain strings that are copied to your clipboard.

Clipboarder is built specifically for my current job, and its formatting is tailored to what I need. 

## Usage

Clipboarder runs in the background and has no front-facing UI like a terminal, window, or tray icon. 
It's recommended to install Clipboarder as a startup app so it's ready to use whenever your workstation is booted up.

## Formatting Options

Clipboarder includes two formatting options: Phone numbers and MAC Addresses. 
Formatting options cannot be customized or changed.

- **Phone Numbers** are formatted to `9999999999` from the following formats:
  - `(999) 999-9999`
  - `999) 999-9999`
  - `999 999 9999`
  - `999-999-9999`

- **MAC Addresses** are formatted to `AAAA.AAAA.AAAA` from the following formats:
  - `AA:AA:AA:AA:AA:AA`
  - `AAAAAAAAAAAA`

## Building

To build Clipboarder, ensure a compatible dart version is installed, then run:
```powershell
dart build exe "bin/clipboarder.dart"
```

Optionally, include a path:
```powershell
dart build exe "bin/clipboarder.dart" -o "build/clipboarder.exe"
```

Then, use Microsoft's `editbin.exe` tool to modify the executable to run in the background:
```powershell
& editbin.exe /SUBSYSTEM:WINDOWS "build\clipboarder.exe"
```
