import 'dart:io';

import 'package:android_package_installer/android_package_installer.dart';
import 'package:flet/flet.dart';
import 'package:flutter/foundation.dart';
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

  Future<void> _installApk(String path) async {
    if (_installing) {
      debugPrint("[APK] Install already in progress.");
      return;
    }

    _installing = true;

    try {
      debugPrint("========== APK INSTALL ==========");
      debugPrint("Path: $path");

      final file = File(path);

      final exists = await file.exists();
      debugPrint("Exists: $exists");

      if (!exists) {
        debugPrint("APK file does not exist.");
        return;
      }

      final size = await file.length();
      debugPrint("Size: $size bytes");

      await AndroidPackageInstaller.installApk(
        apkFilePath: path,
      );

      debugPrint("APK installer launched successfully.");
    } catch (e, stack) {
      debugPrint("========== APK INSTALL FAILED ==========");
      debugPrint(e.toString());
      debugPrint(stack.toString());
    } finally {
      _installing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request =
        widget.control.getString("install_request", "");

    final path =
        widget.control.getString("path", "");

    if (request != null &&
        request.isNotEmpty &&
        request != _lastInstallRequest) {
      _lastInstallRequest = request;

      if (path != null && path.isNotEmpty) {
        debugPrint("[APK] Received install request: $request");

        Future.microtask(() {
          _installApk(path);
        });
      } else {
        debugPrint("[APK] install_request received but path is empty.");
      }
    }

    return LayoutControl(
      control: widget.control,
      child: const SizedBox.shrink(),
    );
  }
}