# Flet APK Installer

A Flet extension that opens Android's native package installer to install an APK from your Python application.

This extension bridges Python and Flutter, allowing Flet applications to request installation of a downloaded APK without manually invoking Android intents from Python.

> **Android only**
>
> This extension has no effect on Windows, Linux, macOS, or Web.

---

## Features

* Opens Android's native APK installer
* Simple Python API
* Native Flutter implementation
* Designed for Flet applications
* Easy to integrate into existing projects

---

## Installation

### From GitHub

Add the dependency to your project's `pyproject.toml`:

```toml
[project]
dependencies = [
    "flet>=0.86.5",
    "flet-apk-installer @ git+https://github.com/radin6262/flet-apk-installer",
]
```

Or install directly:

```bash
pip install "git+https://github.com/radin6262/flet-apk-installer"
```

---

## Usage

```python
import flet as ft
from flet_apk_installer import FletApkInstaller


def main(page: ft.Page):
    page.add(
        FletApkInstaller(
            path="/storage/emulated/0/Download/my_app.apk"
        )
    )


ft.app(main)
```

When the control is added to the page on Android, the system package installer is launched for the specified APK.

---

## Building Your App

Since this package contains native Flutter code, you must build your application with the extension included.

Example:

```bash
flet build apk
```

or

```bash
flet build android
```

If using GitHub Actions, install the extension before building:

```bash
cd flet-apk-installer
pip install -e .
cd ..

flet build apk --release
```

---

## Requirements

* Flet 0.86.5 or newer
* Android device
* Flutter (only when building)
* Python 3.10+

---

## Example

```python
installer = FletApkInstaller(
    path="/storage/emulated/0/Download/FNAF_Launcher/fnaf1.apk"
)

page.add(installer)
```

---

## Notes

* The APK file must already exist.
* The user must allow installation from unknown sources if required by Android.
* Installation is always confirmed by the Android system installer. Apps cannot silently install APKs without privileged permissions.

---

## Repository Structure

```
flet-apk-installer/
├── src/
│   ├── flet_apk_installer/
│   └── flutter/
├── examples/
├── pyproject.toml
└── README.md
```

---

## License

MIT License
