import 'package:firebase_admob/firebase_admob.dart';



class Customadmob {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    childDirected: false,
    designedForFamilies: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd bannerAd(){
    return
      BannerAd (
        adUnitId: 'ca-app-pub-8832245228844811/2501912120',
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        },
      );
  }

  InterstitialAd interstitialAd(){
    return
      InterstitialAd (
        adUnitId: 'ca-app-pub-8832245228844811/3240278727',
        //'ca-app-pub-1624423845873434/3124477666',
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );
  }

}
