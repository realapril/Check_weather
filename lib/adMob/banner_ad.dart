import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:check_weather/auth/secrets.dart';
import 'ad_helper.dart';
import 'package:flutter/foundation.dart';

class BannerAD extends StatefulWidget {
  const BannerAD({Key? key}) : super(key: key);

  @override
  _BannerADState createState() => _BannerADState();
}

class _BannerADState extends State<BannerAD> {
  BannerAd? banner;
  AnchoredAdaptiveBannerAdSize? size;

  @override
  void dispose() {
    super.dispose();
    banner?.dispose();
  }

  Future<AnchoredAdaptiveBannerAdSize?> anchoredAdaptiveBannerAdSize(
      BuildContext context) async {
    return await AdSize.getAnchoredAdaptiveBannerAdSize(
      MediaQuery
          .of(context)
          .orientation == Orientation.portrait
          ? Orientation.portrait
          : Orientation.landscape,
      MediaQuery
          .of(context)
          .size
          .width
          .toInt(),
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
        {
      size = await anchoredAdaptiveBannerAdSize(context);
      setState(() {
        late String adId;
        if (kReleaseMode) {
          adId = admobBannerKey;
        } else {
          adId = AdManager.bannerAdUnitId;
        }
        banner = BannerAd(
          adUnitId: adId,
          size: size!,
          request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (_) {
              setState(() {
                //_isAdLoaded = true;
              });
            },
            onAdFailedToLoad: (ad, error) {
              // Releases an ad resource when it fails to load
              ad.dispose();

              print('Ad load failed (code=${error.code} message=${error
                  .message})');
            },
          ),
        )
          ..load();
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return banner == null //banner is only null for a very less time //don't think that banner will be null if ads fails loads
        ? SizedBox()
        : Container(
      alignment: Alignment.center,
      width: size!.width.toDouble(),
      height: size!.height.toDouble(),
      child: AdWidget(
        ad: banner!,
      ),
    );
  }

}