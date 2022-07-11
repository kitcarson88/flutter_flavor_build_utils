import 'package:device_info_plus/device_info_plus.dart';
import 'package:flavor_build_utils/components/build_tile.dart';
import 'package:flavor_build_utils/utils/flavor_build_utils.dart';
import 'package:flutter/material.dart';

class WebInfosContent extends StatelessWidget {
  final String flavorName;

  const WebInfosContent({
    super.key,
    required this.flavorName,
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: DeviceInfoPlugin().webBrowserInfo,
        builder: (context, AsyncSnapshot<WebBrowserInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          final deviceInfos = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BuildTile(
                  chiave: 'Flavor:',
                  valore: flavorName,
                ),
                BuildTile(
                  chiave: 'Build mode:',
                  valore: FlavorBuildUtils.currentBuildMode().name,
                ),
                BuildTile(
                  chiave: 'Platform:',
                  valore: deviceInfos.platform ?? '',
                ),
                BuildTile(
                  chiave: 'User Agent:',
                  valore: deviceInfos.userAgent ?? '',
                ),
                BuildTile(
                  chiave: 'Browser Vendor:',
                  valore: deviceInfos.vendor ?? '',
                ),
              ],
            ),
          );
        },
      );
}
