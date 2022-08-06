import 'package:cirilla/service/ads_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  final String adSize;
  final int width;
  final int height;

  const BannerAds({Key? key, this.adSize = 'banner', this.width = 250, this.height = 50}) : super(key: key);

  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  // COMPLETE: Add a BannerAd instance
  late BannerAd _ad;

  // COMPLETE: Add _isAdLoaded
  bool _isAdLoaded = false;

  AdSize getAdSize({String size = 'banner', int width = 250, int height = 50}) {
    if (size == 'largeBanner') {
      return AdSize.largeBanner;
    } else if (size == 'mediumRectangle') {
      return AdSize.mediumRectangle;
    } else if (size == 'fullBanner') {
      return AdSize.fullBanner;
    } else if (size == 'leaderboard') {
      return AdSize.leaderboard;
    } else if (size == 'custom') {
      return AdSize(width: width, height: height);
    } else if (size == 'fluid') {
      return AdSize.fluid;
    }
    return AdSize.banner;
  }

  @override
  void initState() {
    super.initState();

    // COMPLETE: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdService.bannerAdUnitId,
      size: getAdSize(size: widget.adSize, width: widget.width, height: widget.height),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          if (kDebugMode) {
            print('Ad load failed (code=${error.code} message=${error.message})');
          }
        },
      ),
    );

    // COMPLETE: Load an ad
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {

    double height = getAdSize(size: widget.adSize).height.toDouble();
    if (widget.adSize == "fluid") {
      height = widget.height.toDouble();
    }

    if (!_isAdLoaded) return SizedBox(height: height);

    return Container(
      child: AdWidget(ad: _ad),
      height: height,
      alignment: Alignment.center,
    );
  }
}
