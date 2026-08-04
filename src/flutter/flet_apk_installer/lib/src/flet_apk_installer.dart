import 'dart:io';

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

  void _sendEvent(String name, String message) {
    widget.control.triggerEvent(name, {
      "message": message,
    });
  }

  Future<void> _installApk(String path) async {
    if (_installing) {
      _sendEvent("debug", "Install already in progress.");
      return;
    }

    _installing = true;

    try {
      final file = File(path);

      _sendEvent("debug", "Checking APK...\n$path");

      final exists = await file.exists();

      if (!exists) {
        _sendEvent("error", "APK does not exist:\n$path");
        return;
      }

      final size = await file.length();

      _sendEvent(
        "debug",
        "APK found.\nSize: $size bytes",
      );

      await AndroidPackageInstaller.installApk(
        apkFilePath: path,
      );

      _sendEvent(
        "success",
        "AndroidPackageInstaller.installApk() completed.",
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
    final request = widget.control.getString("install_request", "");
    final path = widget.control.getString("path", "");

    if (request != null &&
        request.isNotEmpty &&
        request != _lastInstallRequest) {
      _lastInstallRequest = request;

      if (path != null && path.isNotEmpty) {
        Future.microtask(() => _installApk(path));
      } else {
        _sendEvent("error", "install_request received but path is empty.");
      }
    }

    return LayoutControl(
      control: widget.control,
      child: const SizedBox.shrink(),
    );
  }
}