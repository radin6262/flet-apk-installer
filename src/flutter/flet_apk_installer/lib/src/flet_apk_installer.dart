import 'package:android_package_installer/android_package_installer.dart';
import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

class FletApkInstallerControl extends StatefulWidget {
  final Control control;

  const FletApkInstallerControl({
    super.key,
    required this.control,
  });

  @override
  State<FletApkInstallerControl> createState() =>
      _FletApkInstallerControlState();
}

class _FletApkInstallerControlState extends State<FletApkInstallerControl> {
  bool _installing = false;
  String? _lastInstallRequest;

  void _sendEvent(String eventName, String message) {
    try {
      widget.control.triggerEvent(eventName, {
        "message": message,
      });
    } catch (_) {
      debugPrint("[$eventName] $message");
    }
  }

  Future<void> _installApk(String path) async {
    if (_installing) {
      _sendEvent("debug", "Install already in progress.");
      return;
    }

    _installing = true;

    try {
      final file = File(path);
      final absolutePath = file.absolute.path;

      _sendEvent("debug", "APK path:\n$absolutePath");

      final exists = await file.exists();

      if (!exists) {
        _sendEvent(
          "error",
          "APK file does not exist.\n\n$absolutePath",
        );
        return;
      }

      final size = await file.length();

      _sendEvent(
        "debug",
        "APK found.\nSize: $size bytes",
      );

      _sendEvent(
        "debug",
        "Opening Android package installer...",
      );

      await AndroidPackageInstaller.installApk(
        apkFilePath: absolutePath,
      );

      _sendEvent(
        "success",
        "Package installer launched.",
      );

    } catch (e, stack) {
      _sendEvent(
        "error",
        "$e\n\n$stack",
      );
    } finally {
      _installing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request =
        widget.control.getString("install_request", "") ?? "";

    final path =
        widget.control.getString("path", "") ?? "";

    if (request.isNotEmpty &&
        request != _lastInstallRequest) {

      _lastInstallRequest = request;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        if (path.isEmpty) {
          _sendEvent(
            "error",
            "Install request received but path is empty.",
          );
          return;
        }

        _installApk(path);
      });
    }

    return LayoutControl(
      control: widget.control,
      child: const SizedBox.shrink(),
    );
  }
}