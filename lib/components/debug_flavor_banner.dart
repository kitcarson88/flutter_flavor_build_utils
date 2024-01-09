// ignore_for_file: public_member_api_docs, sort_constructors_first
library flavor_build_utils;

import 'dart:async';

import 'package:flavor_build_utils/components/debug_system_infos_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BannerConfig {
  final String bannerName;
  final Color bannerColor;
  final bool isVisible;
  const BannerConfig({required this.bannerName, required this.bannerColor, this.isVisible = false});
}

class ExtraConfig {
  final FutureOr<bool> isGMS;
  final FutureOr<bool> isHMS;

  const ExtraConfig({
    required this.isGMS,
    required this.isHMS,
  });
}

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final BannerConfig bannerConfig;
  final double? width, height;
  final Color? color;
  final ExtraConfig extraConfig;

  const FlavorBanner({
    super.key,
    required this.child,
    required this.bannerConfig,
    this.extraConfig = const ExtraConfig(
      isGMS: false,
      isHMS: false,
    ),
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!bannerConfig.isVisible) return child;

    return Navigator(
      initialRoute: Navigator.defaultRouteName,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) => Stack(
          children: <Widget>[
            child,
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onLongPress: () async {
                final isGMS = await extraConfig.isGMS;
                final isHMS = await extraConfig.isHMS;

                if (context.mounted) {
                  showPlatformDialog(
                      context: context,
                      builder: (BuildContext context) => DeviceInfoDialog(
                            flavorName: bannerConfig.bannerName,
                            isGMS: isGMS,
                            isHMS: isHMS,
                          ));
                }
              },
              child: Container(
                width: width,
                height: height,
                color: color,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: bannerConfig.bannerName,
                    textDirection: Directionality.of(context),
                    layoutDirection: Directionality.of(context),
                    location: BannerLocation.topStart,
                    color: bannerConfig.bannerColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
