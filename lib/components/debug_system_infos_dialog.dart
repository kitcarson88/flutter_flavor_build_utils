library flavor_build_utils;

import 'dart:io';

import 'package:flavor_build_utils/components/android_infos_content.dart';
import 'package:flavor_build_utils/components/ios_infos_content.dart';
import 'package:flavor_build_utils/components/web_infos_content.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DeviceInfoDialog extends StatelessWidget {
  final String flavorName;

  const DeviceInfoDialog({Key? key, required this.flavorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (kIsWeb) {
      body = WebInfosContent(flavorName: flavorName);
    } else if (Platform.isAndroid) {
      body = AndroidInfosContent(flavorName: flavorName);
    } else if (Platform.isIOS) {
      body = IosInfosContent(flavorName: flavorName);
    } else {
      body = const Text("You're not on Android neither iOS");
    }

    return PlatformAlertDialog(
      title: const Text('Device Info'),
      content: body,
      actions: <Widget>[
        PlatformDialogAction(
          onPressed: () => Navigator.pop(context),
          child: PlatformText('Cancel'),
        ),
      ],
    );
  }
}
