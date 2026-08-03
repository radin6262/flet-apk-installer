import 'package:flet/flet.dart';
import 'package:flutter/material.dart';
import 'package:android_package_installer/android_package_installer.dart';

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

  @override
  void initState() {
    super.initState();

    widget.control.onEvent("install", (event) {
      final path = widget.control.getString("path", "");

      if (path != null && path.isNotEmpty) {
        installApk(path);
      }
    });
  }

  Future<void> installApk(String path) async {
    try {
      await AndroidPackageInstaller.installApk(
        apkPath: path,
      );

      debugPrint("APK installer opened");
    } catch (e) {
      debugPrint("APK install failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutControl(
      control: widget.control,
      child: const SizedBox.shrink(),
    );
  }
}