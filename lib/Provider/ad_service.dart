import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class AdMobService {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: null,
    nonPersonalizedAds: true,
    keywords: <String>['Financial', 'Utility'],
  );

  String getAdMobAppId() {
    return 'ca-app-pub-4781014718069770~29181640380';
  }

  static String _getBannerAdId() {
    return 'ca-app-pub-4781014718069770/8710219210';
  }

  static BannerAd profilePageAd;

  static BannerAd _getBannerAd() {
    return BannerAd(
        adUnitId: _getBannerAdId(),
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo);
  }

  static BannerAd showBannerAd() {
    if (profilePageAd == null) profilePageAd = _getBannerAd();
    profilePageAd
      ..load()
      ..show(
        anchorOffset: kBottomNavigationBarHeight,
        anchorType: AnchorType.bottom,
      );
  }

  static void hideBannerAd() async {
    await profilePageAd.dispose();
    profilePageAd = null;
  }
}
