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
  bool installing = false;

  @override
  void initState() {
    super.initState();

    final path = widget.control.getString("path", "");

    if (path != null && path.isNotEmpty) {
      installApk(path);
    }
  }

  Future<void> installApk(String path) async {
    if (installing) return;

    installing = true;

    try {
      await AndroidPackageInstaller.installApk(
        apkFilePath: path,
      );

      debugPrint("APK installer opened");
    } catch (e) {
      debugPrint("APK install failed: $e");
      installing = false;
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