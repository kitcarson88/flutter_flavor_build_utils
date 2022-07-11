import 'package:device_info_plus/device_info_plus.dart';
import 'package:flavor_build_utils/components/build_tile.dart';
import 'package:flavor_build_utils/utils/flavor_build_utils.dart';
import 'package:flutter/material.dart';

class IosInfosContent extends StatelessWidget {
  final String flavorName;

  const IosInfosContent({
    super.key,
    required this.flavorName,
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: DeviceInfoPlugin().iosInfo,
        builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
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
                  chiave: 'Physical device?:',
                  valore: deviceInfos.isPhysicalDevice.toString(),
                ),
                const BuildTile(
                  chiave: 'Manufacturer:',
                  valore: 'Apple',
                ),
                BuildTile(
                  chiave: 'Model:',
                  valore: deviceInfos.name ?? '',
                ),
                BuildTile(
                  chiave: 'iOS version:',
                  valore: deviceInfos.systemVersion ?? '',
                ),
              ],
            ),
          );
        },
      );
}
