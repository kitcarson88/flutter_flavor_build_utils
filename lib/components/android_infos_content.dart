import 'package:device_info_plus/device_info_plus.dart';
import 'package:flavor_build_utils/components/build_tile.dart';
import 'package:flavor_build_utils/utils/flavor_build_utils.dart';
import 'package:flutter/material.dart';

class AndroidInfosContent extends StatelessWidget {
  final String flavorName;
  final bool isGMS, isHMS;

  const AndroidInfosContent({
    super.key,
    required this.flavorName,
    required this.isGMS,
    required this.isHMS,
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: DeviceInfoPlugin().androidInfo,
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
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
                BuildTile(
                  chiave: 'Manufacturer:',
                  valore: deviceInfos.manufacturer,
                ),
                BuildTile(
                  chiave: 'Model:',
                  valore: deviceInfos.model,
                ),
                BuildTile(
                  chiave: 'Android version:',
                  valore: deviceInfos.version.release,
                ),
                BuildTile(
                  chiave: 'Android SDK:',
                  valore: deviceInfos.version.sdkInt.toString(),
                ),
                BuildTile(
                  chiave: 'Google Message Services:',
                  valore: isGMS.toString(),
                ),
                BuildTile(
                  chiave: 'Huawei Mobile Services',
                  valore: isHMS.toString(),
                ),
              ],
            ),
          );
        },
      );
}
