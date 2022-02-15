library flavor_build_utils;

import 'package:flavor_build_utils/components/debug_system_infos_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BannerConfig {
  final String? bannerName;
  final Color? bannerColor;
  final bool isVisible;
  const BannerConfig({this.bannerName, this.bannerColor, this.isVisible = false});
}

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final BannerConfig bannerConfig;
  final double? width, height;
  final Color? color;

  const FlavorBanner({
    Key? key,
    required this.child,
    BannerConfig? bannerConfig,
    this.width,
    this.height,
    this.color,
  })  : bannerConfig = bannerConfig ?? const BannerConfig(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!bannerConfig.isVisible) return child;

    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  Widget _buildBanner(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: () {
          showPlatformDialog(
              context: context,
              builder: (BuildContext context) => DeviceInfoDialog(
                    flavorName: bannerConfig.bannerName ?? 'N/A',
                  ));
        },
        child: Container(
          width: width,
          height: height,
          color: color,
          child: CustomPaint(
            painter: BannerPainter(
                message: bannerConfig.bannerName!,
                textDirection: Directionality.of(context),
                layoutDirection: Directionality.of(context),
                location: BannerLocation.topStart,
                color: bannerConfig.bannerColor!),
          ),
        ),
      );
}
