import 'dart:io';


class AdsManger {
  static bool _testmode = true;

  static String get appIdEx {
    if (Platform.isAndroid) {
      return "ca-app-pub-7757590907378676~5669556085";
    } else if (Platform.isIOS) {
      return "....";
    } else {
      throw new UnsupportedError("UNSUPPORTED PLATFORM");
    }
  }

  static String get BannerAdUnitIdEX {
    if (_testmode == true) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8832245228844811/5482892164";
    } else if (Platform.isIOS) {
      return "....";
    } else {
      throw new UnsupportedError("UNSUPPORTED PLATFORM");
    }
  }

  static String get nativeAdunit {
    if (_testmode == true) {
      return "ca-app-pub-3940256099942544/2247696110";

      //NativeAdmob.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-7757590907378676/1957592387";
    } else if (Platform.isIOS) {
      return "....";
    } else {
      throw new UnsupportedError("UNSUPPORTED PLATFORM");
    }
  }

  static String get interstitialAd {
    if (_testmode == true) {
      //  return AdmobInterstitial.testAdUnitId;
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8832245228844811/4121709038";
    } else if (Platform.isIOS) {
      return "....";
    } else {
      throw new UnsupportedError("UNSUPPORTED PLATFORM");
    }
  }
}
