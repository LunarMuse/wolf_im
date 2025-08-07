import 'package:flutter/cupertino.dart';
import 'package:wolf_im/l10n/l10n.dart';

class AppConstField {
  // 小文字大小
  static const String version = 'V1.0.0';
  static const String appName = 'Wolf IM';

  static const String appSplashLeading = 'Wolf IM Splash';
  static const String appSplashLogo = 'assets/images/icon_head.webp';
  static const String appSplashBottomText1 = '这是启动页Power By wolf';
  static const String appSplashBottomText2 = '· 2025 ·  @liangjingjing ';
  static const String appSplashColorfulText = 'M';

  static const double appMenuBarLeadingCircleImageSize = 60;
  static const String appMenuBarLeadingCircleImage =
      'assets/images/icon_head.webp';
  static const String appMenuBarLeadingName = 'wolf';

  static String galleryDesc(BuildContext context) =>
      """
[
  {
    "image":"assets/images/anim_draw.webp",
    "name": "${context.l10n.basicDrawing}",
    "info": "${context.l10n.basicDrawingDesc}"
  },
    {
    "image":"assets/images/draw_bg3.webp",
    "name": "${context.l10n.animationGesture}",
    "info": "${context.l10n.animationGestureDesc}"
  },
    {
    "image":"assets/images/base_draw.webp",
     "name": "${context.l10n.particleDrawing}",
    "info": "${context.l10n.particleDrawingDesc}"
    },
    {
    "image":"assets/images/draw_bg4.webp",
        "name": "${context.l10n.interestingDrawing}",
    "info": "${context.l10n.interestingDrawingDesc}"},
    {
    "image":"assets/images/caver.webp",
        "name": "${context.l10n.artGallery}",
    "info": "${context.l10n.artGalleryDesc}"}
]
""";
}
