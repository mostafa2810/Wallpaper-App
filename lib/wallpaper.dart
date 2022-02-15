import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutt/admob.dart';
import 'package:flutt/adsManger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class wallpaper extends StatefulWidget {
  @override
  _wallpaperState createState() => _wallpaperState();
}

class _wallpaperState extends State<wallpaper> {
  List<String> image = [
    'assets/s1.jpg',
    'assets/s2.jpg',
    'assets/s3.jpg',
    'assets/s4.jpg',
    'assets/s7.jpg',
    'assets/s8.jpg',
    'assets/s9.jpg',
    'assets/s10.jpg',
    'assets/s11.jpg',
    'assets/s12.jpg',
    'assets/s13.jpg',
    'assets/s14.jpg',
    'assets/s15.jpg',
    'assets/s16.jpg',
    'assets/s17.jpg',
    'assets/s18.jpg',
    'assets/s19.jpg',
    'assets/s20.jpg',
    'assets/s21.jpg',
    'assets/s22.jpg',
    'assets/s23.jpg',
    'assets/s24.jpg',
    'assets/s25.jpg',
    'assets/s26.jpg',
    'assets/s27.jpg',
    'assets/s28.jpg',
    'assets/s29.jpg',
    'assets/s30.jpg',
    'assets/s31.jpg',
    'assets/s32.jpg',
    'assets/s33.jpg',
    'assets/s34.jpg',
    'assets/s35.jpg',
    'assets/s36.jpg',
    'assets/s37.jpg',
    'assets/s38.jpg',
    'assets/s39.jpg',
    'assets/s40.jpg',
    'assets/s41.jpg',
    'assets/s42.jpg',
    'assets/s43.jpg',
    'assets/s44.jpg',
    'assets/s45.jpg',
    'assets/s46.jpg',
    'assets/s47.jpg',
    'assets/s48.jpg',
    'assets/s49.jpg',
    'assets/s50.jpg',
    'assets/s51.jpg',
    'assets/s52.jpg',
    'assets/s53.jpg',
    'assets/s54.jpg',
    'assets/s55.jpg',
    'assets/s56.jpg',
    'assets/s57.jpg',
    'assets/s58.jpg',
    'assets/s59.jpg',
    'assets/s60.jpg',
    'assets/s61.jpg',
    'assets/s62.jpg',
    'assets/s63.jpg',
    'assets/s64.jpg',
    'assets/s65.jpg',
    'assets/s66.jpg',
    'assets/s67.jpg',
    'assets/s68.jpg',
    'assets/s69.jpg',
    'assets/s70.jpg',
    'assets/s71.jpg',
    'assets/s72.jpg',
    'assets/s73.jpg',
    'assets/s74.jpg',
    'assets/s75.jpg',
    'assets/s76.jpg'
        'assets/s77.jpg',
    'assets/s78.jpg',
    'assets/s79.jpg',
    'assets/s80.jpg',
    'assets/s81.jpg',
    'assets/s82.jpg',
    'assets/s83.jpg'
  ];
    final _nativeAd = NativeAdmobController();
  String _wallpaperAsset = "unknown";
  AdmobInterstitial intersitialAd;
  String testDevice = 'Mobile_id';
  Customadmob myCustomadmob = Customadmob();
  @override
  void initState() {
    showInterstialAd();
    intersitialAd = AdmobInterstitial(
        adUnitId: AdsManger.interstitialAd,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) intersitialAd.load();
        });
    intersitialAd.load();
    _nativeAd.reloadAd(forceRefresh: true);
    super.initState();
    
    _requestPermiision();
  }

  @override
  void dispose() {
    intersitialAd.dispose();
    _nativeAd.dispose();
    super.dispose();
  }

  showInterstialAd() {
    myCustomadmob.interstitialAd()
      ..load()
      ..show(
        //  anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  show(String path) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(actions: [
            FlatButton(
                onPressed: () {
                  setWallpaperFromAsset(path);
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text(" done "),
                            content: new Text("تم تغيير الخلفية بنجاح "),
                          ));
                },
                child: Text(
                  'تعيين كخلفية للهاتف ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ))
          ]);
        });
  }

  Future<void> setWallpaperFromAsset(String path) async {
    setState(() {
      _wallpaperAsset = "Loading";
    });
    String result;
    String assetPath = path;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromAsset(
          assetPath, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    setState(() {
      _wallpaperAsset = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: GridView.builder(
              itemCount: image.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    /* Container(
                  //width:310,
                  height:60,
                  child:NativeAdmob(
                    adUnitID:AdsManger.nativeAdunit,
                    numberAds:3,
                    controller: _nativeAd,
                    type:NativeAdmobType.banner,
                  )
              ),*/
                    Card(
                      elevation: 10,
                      child: InkWell(
                        child: Image.asset(image[index]),
                        onTap: () {
                          show(image[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 2),
                  ],
                );
              })),
    );
  }
}

_requestPermiision() async {
  Map<Permission, PermissionStatus> statues = await [
    Permission.storage,
  ].request();
}
