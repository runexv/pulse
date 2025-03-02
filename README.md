# pulse 😮‍💨

[![license: mit](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/pulse/pulse/releases)

a simple command-line tool for checking website accessibility and monitoring uptime. made with v.

## features

- 🔍 check website accessibility and response codes
- 🔄 live monitoring with custom refresh intervals
- 🌐 auto url formatting (adds https and www)
- 🎨 colored console output for better reading
- 🌍 works on windows, linux, macos
- 🚀 auto curl install (linux and macos)

## installation

### tutorial

1. download the latest release from the releases page
2. put the file into `%USERPROFILE%\AppData\Local\Microsoft\WindowsApps`
3. done!

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
