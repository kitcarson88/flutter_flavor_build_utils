library flavor_build_utils;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flavor_build_utils/utils/flavor_build_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DeviceInfoDialog extends StatelessWidget {
  final String flavorName;

  const DeviceInfoDialog({Key? key, required this.flavorName}) : super(key: key);

  @override
  Widget build(BuildContext context) => PlatformAlertDialog(
        title: const Text('Device Info'),
        content: _getContent(),
        actions: <Widget>[
          PlatformDialogAction(
            onPressed: () => Navigator.pop(context),
            child: PlatformText('Cancel'),
          ),
        ],
      );

  Widget _getContent() {
    if (kIsWeb) {
      return _webContent();
    } else if (Platform.isAndroid) {
      return _androidContent();
    } else if (Platform.isIOS) {
      return _iOSContent();
    }

    return const Text("You're not on Android neither iOS");
  }

  Widget _webContent() => FutureBuilder(
      future: DeviceInfoPlugin().webBrowserInfo,
      builder: (context, AsyncSnapshot<WebBrowserInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final deviceInfos = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor:', flavorName),
              _buildTile('Build mode:', FlavorBuildUtils.currentBuildMode().name),
              _buildTile('Platform:', deviceInfos.platform ?? ''),
              _buildTile('User Agent:', deviceInfos.userAgent ?? ''),
              _buildTile('Browser Vendor:', deviceInfos.vendor ?? ''),
            ],
          ),
        );
      });

  Widget _androidContent() => FutureBuilder(
      future: DeviceInfoPlugin().androidInfo,
      builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final deviceInfos = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor:', flavorName),
              _buildTile('Build mode:', FlavorBuildUtils.currentBuildMode().name),
              _buildTile('Physical device?:', '${deviceInfos.isPhysicalDevice}'),
              _buildTile('Manufacturer:', '${deviceInfos.manufacturer}'),
              _buildTile('Model:', '${deviceInfos.model}'),
              _buildTile('Android version:', '${deviceInfos.version.release}'),
              _buildTile('Android SDK:', '${deviceInfos.version.sdkInt}')
            ],
          ),
        );
      });

  Widget _iOSContent() => FutureBuilder(
      future: DeviceInfoPlugin().iosInfo,
      builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final deviceInfos = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor:', flavorName),
              _buildTile('Build mode:', FlavorBuildUtils.currentBuildMode().name),
              _buildTile('Physical device?:', '${deviceInfos.isPhysicalDevice}'),
              _buildTile('Manufacturer:', 'Apple'),
              _buildTile('Model:', '${deviceInfos.name}'),
              _buildTile('iOS version:', '${deviceInfos.systemVersion}'),
            ],
          ),
        );
      });

  Widget _buildTile(String key, String value) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(
              '$key ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value)
          ],
        ),
      );
}
