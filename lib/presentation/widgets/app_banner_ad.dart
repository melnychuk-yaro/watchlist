import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ad_helper.dart';

class AppBannerAd extends StatefulWidget {
  @override
  _AppBannerAdState createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  late BannerAd _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: AdListener(
        onAdLoaded: (_) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (_, error) =>
            setState(() => print('Ad faild to load with error $error')),
      ),
      request: AdRequest(),
    );
    _ad.load();
  }

  @override
  void dispose() {
    super.dispose();
    _ad.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Container(
            height: _ad.size.height.toDouble(),
            child: AdWidget(
              ad: _ad,
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
