# flet-apk-installer

flet-apk-installer [Flet](https://flet.dev) extension.

<!--- If your extension wraps a Flutter package, credit it here, ex:
It is based on the [xyz](https://pub.dev/packages/xyz) Flutter package. -->

## Platform Support

<!--- Update the table accordingly for your extension, using ✅ and ❌. -->

| Platform  | iOS | Android | Web | Windows | macOS | Linux |
|-----------|-----|---------|-----|---------|-------|-------|
| Supported | ❌   | ✅       | ❌   | ❌       | ❌     | ❌     |

## Usage

### Installation

Add `flet-apk-installer` dependency to the `pyproject.toml` of your Flet project:

* **From Git**

```toml
dependencies = [
  "flet-apk-installer @ git+https://github.com/MY_GITHUB_ACCOUNT/flet-apk-installer",
  "flet>=0.86.5",
]
```

<!--- Remove below list item, if your extension isn't yet available on PyPI. -->

* **From PyPI**

```toml
dependencies = [
  "flet-apk-installer",
  "flet>=0.86.5",
]
```

### Run your app

A Flet extension has two sides: its Python controls/services and the native Flutter/Dart widgets behind them.
That native code must be compiled into a Flet client before your controls can render, and the
prebuilt client that a plain `flet run` uses does **not** include this extension.

So run your app in one of these two ways:

**1. [`flet debug`](https://flet.dev/docs/cli/flet-debug)** — all platforms: *Windows, macOS, Linux, Web, iOS, Android*

Compiles the extension and launches your app on the target you pick. 
The simplest option, and the way to go for mobile and web:

```bash
flet debug macos                   # desktop & web: no device needed
flet debug android -d <device-id>  # mobile: connect a device/emulator first
```

For iOS and Android, pass `-d <device-id>` (run `flet debug --show-devices` to list connected devices).
Edits to your **Python** code are picked up the next time you run `flet debug`.

**2. [`flet build`](https://flet.dev/docs/cli/flet-build) once, then [`flet run`](https://flet.dev/docs/cli/flet-run)** — desktop only: *Windows, macOS, Linux*

Build a custom client that bundles the extension **once**, then use `flet run` for a fast hot-reload loop while you edit Python:

```bash
flet build macos  # or: flet build windows / flet build linux
flet run          # run from the folder where build/ was created, so it reuses that client
```

`flet run` auto-detects the client under `build/<platform>/`, so your Python edits hot-reload instantly.
Rebuild only when the extension's **Dart** code changes.

### Examples

See the [examples](examples) directory.

### Documentation

<!--- Update the link, if your docs are elsewhere. Alternatively, you could write out all docs in this section directly. -->

Detailed documentation for this package can be found [here](https://MY_GITHUB_ACCOUNT.github.io/flet-apk-installer/).
**# flet-apk-installer

[![PyPI](https://img.shields.io/pypi/v/flet-apk-installer)](https://pypi.org/project/flet-apk-installer/)
[![Python](https://img.shields.io/pypi/pyversions/flet-apk-installer)](https://pypi.org/project/flet-apk-installer/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A simple Android APK installation extension for [Flet](https://flet.dev).

`flet-apk-installer` allows Flet Android applications to open and install APK files using the Android system package installer without requiring developers to manually handle Android intents, `FileProvider`, or Java bridge code.

Built for Flet applications that need APK installation functionality, such as:

* Game launchers
* App managers
* Update systems
* Custom Android tools

---

## Features

* Install APK files from Flet Android applications
* Simple Python API
* Built-in installation callbacks
* No manual Android intent handling
* No manual `FileProvider` setup
* Works with Flet extensions
* Uses Android's official package installer flow

---

## Platform Support

| Platform  | iOS | Android | Web | Windows | macOS | Linux |
| --------- | --- | ------- | --- | ------- | ----- | ----- |
| Supported | ❌   | ✅       | ❌   | ❌       | ❌     | ❌     |

---

## Installation

Install from PyPI:

```bash
pip install flet-apk-installer
```

Or add it to your Flet project's `pyproject.toml`:

```toml
dependencies = [
    "flet-apk-installer",
    "flet>=0.86.5",
]
```

---

## Android Configuration

APK installation requires Android's install package permission.

Add the following permission to your Flet Android configuration:

```toml
[tool.flet.android]

permissions = [
    "android.permission.REQUEST_INSTALL_PACKAGES"
]
```

Android may also require the user to allow your application to install unknown apps:

```
Settings → Install unknown apps → Your application → Allow
```

This is an Android security requirement and cannot be bypassed by normal applications.

---

## Quick Start

```python
import flet as ft
from flet_apk_installer import FletApkInstaller


def main(page: ft.Page):

    def on_debug(message):
        print("DEBUG:", message)

    def on_success(message):
        print("SUCCESS:", message)

    def on_error(message):
        print("ERROR:", message)


    installer = FletApkInstaller(
        on_debug=on_debug,
        on_success=on_success,
        on_error=on_error,
    )


    def install_apk(e):
        installer.path = "/path/to/application.apk"
        installer.install()


    page.add(
        ft.ElevatedButton(
            "Install APK",
            on_click=install_apk,
        ),
        installer,
    )


ft.app(target=main)
```

---

## How It Works

The installation flow is:

```
Your Flet App
      |
      v
flet-apk-installer
      |
      v
Android Package Installer
      |
      v
User confirms installation
```

The package does not install applications silently. Android requires user confirmation for security reasons.

---

## Callbacks

`FletApkInstaller` provides callbacks for monitoring installation status.

### Debug Callback

Called for installation progress messages.

```python
def on_debug(message):
    print(message)
```

---

### Success Callback

Called when the installation process completes successfully.

```python
def on_success(message):
    print(message)
```

---

### Error Callback

Called when an installation error occurs.

```python
def on_error(message):
    print(message)
```

---

## Example Projects

`flet-apk-installer` can be used in applications such as:

* Android game launchers
* Custom app stores
* APK update managers
* Internal enterprise tools

Example:

A game launcher can:

1. Download an APK
2. Verify the file
3. Pass the APK path to `FletApkInstaller`
4. Open Android's installer

---

## Important Notes

* Android only.
* The APK file must already exist on the device.
* The user must approve installation.
* Silent installation is not possible for normal Android applications.
* The extension must be included in the Flet Android build.

---

## Running With Flet

Because this is a Flet extension, the native extension code must be included in your application.

Use:

```bash
flet debug android -d <device-id>
```

or build your application:

```bash
flet build apk
```

The standard Flet client does not contain third-party extensions.

---

## Documentation

Full usage documentation:

```
https://radin6262.github.io/flet-apk-installer/
```

---

## License

MIT License
