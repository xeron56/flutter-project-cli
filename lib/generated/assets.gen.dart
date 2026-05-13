// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $GoogleFontsGen {
  const $GoogleFontsGen();

  /// File path: google_fonts/Roboto-Medium.ttf
  String get robotoMedium => 'google_fonts/Roboto-Medium.ttf';

  /// List of all assets
  List<String> get values => [robotoMedium];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/navigation
  $AssetsIconsNavigationGen get navigation => const $AssetsIconsNavigationGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/chevrons-right.svg
  SvgGenImage get chevronsRight =>
      const SvgGenImage('assets/images/chevrons-right.svg');

  /// File path: assets/images/file_doc.svg
  SvgGenImage get fileDoc => const SvgGenImage('assets/images/file_doc.svg');

  /// File path: assets/images/file_pdf.svg
  SvgGenImage get filePdf => const SvgGenImage('assets/images/file_pdf.svg');

  /// File path: assets/images/giveway_outline.svg
  SvgGenImage get givewayOutline =>
      const SvgGenImage('assets/images/giveway_outline.svg');

  /// File path: assets/images/google_pay.svg
  SvgGenImage get googlePay =>
      const SvgGenImage('assets/images/google_pay.svg');

  /// File path: assets/images/help_outline.svg
  SvgGenImage get helpOutline =>
      const SvgGenImage('assets/images/help_outline.svg');

  /// File path: assets/images/hide.svg
  SvgGenImage get hide => const SvgGenImage('assets/images/hide.svg');

  /// File path: assets/images/icon_star.svg
  SvgGenImage get iconStar => const SvgGenImage('assets/images/icon_star.svg');

  /// File path: assets/images/icon_star_active.svg
  SvgGenImage get iconStarActive =>
      const SvgGenImage('assets/images/icon_star_active.svg');

  /// File path: assets/images/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/images/phone.svg');

  /// File path: assets/images/trip_outline.svg
  SvgGenImage get tripOutline =>
      const SvgGenImage('assets/images/trip_outline.svg');

  /// File path: assets/images/twemoji_sun_behind_cloud.svg
  SvgGenImage get twemojiSunBehindCloud =>
      const SvgGenImage('assets/images/twemoji_sun_behind_cloud.svg');

  /// File path: assets/images/visa.svg
  SvgGenImage get visa => const SvgGenImage('assets/images/visa.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    chevronsRight,
    fileDoc,
    filePdf,
    givewayOutline,
    googlePay,
    helpOutline,
    hide,
    iconStar,
    iconStarActive,
    phone,
    tripOutline,
    twemojiSunBehindCloud,
    visa,
  ];
}

class $AssetsIconsNavigationGen {
  const $AssetsIconsNavigationGen();

  /// File path: assets/icons/navigation/icon_contacts.svg
  SvgGenImage get iconContacts =>
      const SvgGenImage('assets/icons/navigation/icon_contacts.svg');

  /// File path: assets/icons/navigation/icon_contacts_outline.svg
  SvgGenImage get iconContactsOutline =>
      const SvgGenImage('assets/icons/navigation/icon_contacts_outline.svg');

  /// List of all assets
  List<SvgGenImage> get values => [iconContacts, iconContactsOutline];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $GoogleFontsGen googleFonts = $GoogleFontsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
