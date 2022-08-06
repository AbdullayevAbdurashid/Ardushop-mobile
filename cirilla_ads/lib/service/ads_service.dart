import 'dart:io';

import 'package:cirilla/constants/ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  Future<InitializationStatus> initialization;

  AdService(this.initialization);

  static String get bannerAdUnitId =>
      Platform.isAndroid ? bannerAdUnitIdAndroid : bannerAdUnitIdiOS;
}
