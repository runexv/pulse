# pulse 😮‍💨

[![license: mit](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/runexv/pulse/releases)

a simple command-line tool for checking website accessibility and monitoring uptime. made with v.

## features

- 🔍 check website accessibility and response codes
- 🔄 live monitoring with custom refresh intervals
- 🌐 auto url formatting (adds https and www)
- 🎨 colored console output for better reading
- 🌍 works on windows, linux, macos
- 🚀 auto curl install (linux and macos)

## installation

### windows

1. download pulse.exe from releases page
2. move pulse.exe to %USERPROFILE%\pulse
3. type `setx PATH "%PATH%;%USERPROFILE%\pulse"` in cmd
4. done! try `pulse` to test

### linux/macos

1. download git from https://git-scm.com/downloads
2. open terminal and type `git clone https://github.com/runexv/pulse && cd pulse`
3. install v from https://vlang.io/
4. open terminal in downloads dir and type `curl -fss -o v_linux.zip https://github.com/vlang/v/releases/download/weekly.2025.09/v_linux.zip`
5. type `sudo unzip v_linux.zip -d /v`
6. type `export PATH=$PATH:/v`
7. go back to directory with pulse and type `v src/main.v -o pulse.exe`
8. type `pulse` to test

### requirements

- curl (comes with Windows 10+, Linux, and macOS)

### usage

```
pulse <link> [options]
```

### options

- `-v, --version` - show pulse's version number and exit
- `-l, --live` - monitor website for changes in availability
- `--t <seconds>` - set refresh interval for live monitoring (default: 15s)

### examples

```
# check website status
pulse example.com

# monitor website with refresh rate of 30s
pulse example.com -l --t 30
```
