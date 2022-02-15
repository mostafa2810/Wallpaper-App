import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

import 'package:url_launcher/url_launcher.dart';
import 'adsManger.dart';
import 'colorr.dart';

class profile2 extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<profile2> {
  String allposts;
  AdmobBannerSize bannerSize;
  AdmobInterstitial intersitialAd;
  final _nativeAd = NativeAdmobController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String v;
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;

  int money = 0;
  int coins = 0;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  SharedPreferences prefs;

  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-7757590907378676~5669556085');
    setState(() {
      getData();
      getData2();
    });

    RewardedVideoAd.instance.load(
        adUnitId: '	ca-app-pub-3940256099942544/5224354917',
        //'ca-app-pub-7757590907378676/2778691799',
        //AdmobReward.testAdUnitId,
        // "ca-app-pub-9553580055895935/1690226045",
        targetingInfo: MobileAdTargetingInfo());

    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        coins = coins + rewardAmount;
      }
    };

    super.initState();
    bannerSize = AdmobBannerSize.BANNER;

    intersitialAd = AdmobInterstitial(
        adUnitId: 'ca-app-pub-7757590907378676/7279534119',
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) intersitialAd.load();
          //  handleEvent(event, args, 'Interstitial');
        });
    _nativeAd.reloadAd(forceRefresh: true);
    intersitialAd.load();
    void showSnackBar(String content) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(milliseconds: 2500),
        ),
      );
    }

    void handleEvent(
        AdmobAdEvent event, Map<String, dynamic> args, String adType) {
      switch (event) {
        case AdmobAdEvent.loaded:
          showSnackBar('New Admob $adType Ad loaded!');
          break;
        case AdmobAdEvent.opened:
          showSnackBar('Admob $adType Ad opened!');
          break;
        case AdmobAdEvent.closed:
          showSnackBar('Admob $adType Ad closed!');
          break;
        case AdmobAdEvent.failedToLoad:
          showSnackBar('Admob $adType failed to load. :(');
          break;
        case AdmobAdEvent.rewarded:
          showDialog(
            context: scaffoldState.currentContext,
            builder: (BuildContext context) {
              return WillPopScope(
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Reward callback fired. Thanks Andrew!'),
                      Text('Type: ${args['type']}'),
                      Text('Amount: ${args['amount']}'),
                    ],
                  ),
                ),
                onWillPop: () async {
                  scaffoldState.currentState.hideCurrentSnackBar();
                  return true;
                },
              );
            },
          );
          break;
        default:
      }
    }
  }

  saveData(int coin) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('coin2', coin);
    // prefs.setInt('money',m);
  }

  saveData2(int m) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('money', m);
    // prefs.setInt('money',m);
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // money =prefs.getInt('money')??money;
      coins = prefs.getInt('coin2') ?? coins;
    });
  }

  getData2() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      money = prefs.getInt('money') ?? money;
      // coins =prefs.getInt('coins')??coins;
    });
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    intersitialAd.dispose();
    _nativeAd.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Center(
              child: Row(
            children: [
              SizedBox(width: 40),
              Text(' و الصور ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      fontSize: 23)),
              Text(' الربح',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
            ],
          )),
          backgroundColor: Colors.red,
          elevation: 6,
        ),

        //drawer: SidebarPage(),

        body: Form(
          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black],
              ),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                    width: 310,
                    height: 82,
                    child: NativeAdmob(
                      adUnitID: AdsManger.nativeAdunit,
                      numberAds: 3,
                      controller: _nativeAd,
                      type: NativeAdmobType.banner,
                    )),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Container(width: 90, child: Image.asset('assets/R.png')),
                    SizedBox(width: 10),
                    Container(width: 90, child: Image.asset('assets/r2.png')),
                    SizedBox(width: 3),
                    Text(
                      '%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'تطبيق صادق 100',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 100,
                      height: 112,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red,
                            Colors.redAccent,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                      ),
                      child: FlatButton(
                          child: Center(
                            child: Text(
                              'اربح كوينز ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            videoAd.load(
                                adUnitId:
                                    'ca-app-pub-3940256099942544/5224354917'
                                //AdmobReward.testAdUnitId,
                                // 'ca-app-pub-7757590907378676/2778691799',
                                //RewardedVideoAd
                                //   .testAdUnitId
                                );
                            //updataData();
                            videoAd.show();
                            RewardedVideoAd.instance.listener =
                                (RewardedVideoAdEvent event,
                                    {String rewardType, int rewardAmount}) {
                              if (event == RewardedVideoAdEvent.rewarded) {
                                setState(() {
                                  coins = coins + 1;
                                  // rewardAmount;
                                });
                              }
                              saveData(coins);
                              saveData2(money);
                            };
                            print("ggg");
                          }),
                      /*  child:   FlatButton(
                                                   child: Center(
                                                     child: Text(
                                                       'اربح كوينز' ,
                                                       style: TextStyle(
                                                           color: Colors
                                                               .white,
                                                           fontSize: 17,
                                                           fontWeight: FontWeight
                                                               .bold),),
                                                   )

                                                   , onPressed: () async{
                                                     
                                                     bool _needToWait = true;
                                                     SharedPreferences _prefs = await SharedPreferences.getInstance();
                                                     try{
                                                       String _value = await _prefs.getString('LastAdTime');
                                                       if(_value == null || _value.isEmpty){
                                                        setState(() {
                                                           _needToWait = false;
                                                        });
                                                       }else{
                                                         DateTime _time = await DateTime.now();
                                                         DateTime _time2 = await DateTime.parse(await _prefs.getString('LastAdTime'));
                                                         var _diff = await _time.difference(_time2).inMinutes;
                                                         print(_diff);
                                                         if(_diff > 2){
                                                           
                                                           setState(() {
                                                             _needToWait = false;
                                                           });

                                                         }else if (_diff <= 2){
                                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You need to wait 2 minutes')));
                                                           setState(() {
                                                             _needToWait = true;
                                                           });
                                                         }
                                                       }
                                                     } on Exception catch (e){
                                                       throw Exception('An Error has occured');
                                                     }
                                                     if(!_needToWait){
                                                  videoAd.load(
                                                     adUnitId:	'ca-app-pub-3940256099942544/5224354917'
                                                     //'ca-app-pub-4801644190189400/4424659381'
                                                   //AdmobReward.testAdUnitId,
                                                  // 'ca-app-pub-7757590907378676/2778691799',
                                                     //RewardedVideoAd
                                                      //   .testAdUnitId
                                                 );
                                                 //updataData();
                                                 videoAd.show();
                                                 RewardedVideoAd.instance
                                                     .listener =
                                                     (
                                                     RewardedVideoAdEvent event,
                                                     {String rewardType, int rewardAmount}) async {
                                                   if (event ==
                                                       RewardedVideoAdEvent
                                                           .rewarded) {
                                                await _prefs.setString('LastAdTime', await DateTime.now().toString());
                                                     setState(() {
                                                       coins = coins + 1;
                                                          // rewardAmount;
                                                     });
                                                   }
                                                   saveData(coins);
                                                   saveData2(money);
                                                 };

                                                     }
                                        
                                               }
                                               ),

*/
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            width: 100,
                            height: 112,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.red,
                                  Colors.red,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                            ),
                            child: FlatButton(
                                child: Center(
                                  child: Text(
                                    'اربح كوينز',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () async {
                                  videoAd.load(
                                      adUnitId:
                                          'ca-app-pub-3940256099942544/5224354917'
                                      //AdmobReward.testAdUnitId,
                                      // 'ca-app-pub-7757590907378676/2778691799',
                                      //RewardedVideoAd
                                      //   .testAdUnitId
                                      );
                                  //updataData();
                                  videoAd.show();
                                  RewardedVideoAd.instance.listener =
                                      (RewardedVideoAdEvent event,
                                          {String rewardType,
                                          int rewardAmount}) {
                                    if (event ==
                                        RewardedVideoAdEvent.rewarded) {
                                      setState(() {
                                        coins = coins + 1;
                                        // rewardAmount;
                                      });
                                    }
                                    saveData(coins);
                                    saveData2(money);
                                  };
                                  print("ggg");

                                  //                                               await StartApp
                                  //                                               .showRewardedAd(onVideoCompleted: () {
                                  // setState(() {
                                  // coins = coins + 1;
                                  //
                                  // // rewardAmount;
                                  // });
                                  //
                                  // saveData(coins);
                                  // saveData2(money);
                                  //                                                 // video completed callback
                                  //                                               }, onReceiveAd: () {
                                  //                                                 // ad received callback
                                  //                                               }, onFailedToReceiveAd: (String error) {
                                  //                                                 // failed to received ad callback
                                  //                                               });
                                  //
                                })),
                        Container(
                            width: 100,
                            height: 112,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.red,
                                  Colors.red,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                            ),
                            child: FlatButton(
                                child: Center(
                                  child: Text(
                                    'اربح كوينز',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () async {
                                  videoAd.load(
                                      adUnitId:
                                          'ca-app-pub-3940256099942544/5224354917'
                                      //AdmobReward.testAdUnitId,
                                      // 'ca-app-pub-7757590907378676/2778691799',
                                      //RewardedVideoAd
                                      //   .testAdUnitId
                                      );
                                  //updataData();
                                  videoAd.show();
                                  RewardedVideoAd.instance.listener =
                                      (RewardedVideoAdEvent event,
                                          {String rewardType,
                                          int rewardAmount}) {
                                    if (event ==
                                        RewardedVideoAdEvent.rewarded) {
                                      setState(() {
                                        coins = coins + 1;
                                        // rewardAmount;
                                      });
                                    }
                                    saveData(coins);
                                    saveData2(money);
                                  };
                                  print("ggg");
                                  //                                               await StartApp
                                  //                                               .showRewardedAd(onVideoCompleted: () {
                                  // setState(() {
                                  // coins = coins + 1;
                                  //
                                  // // rewardAmount;
                                  // });
                                  //
                                  // saveData(coins);
                                  // saveData2(money);
                                  //                                                 // video completed callback
                                  //                                               }, onReceiveAd: () {
                                  //                                                 // ad received callback
                                  //                                               }, onFailedToReceiveAd: (String error) {
                                  //                                                 // failed to received ad callback
                                  //                                               });
                                  //
                                })),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            child: Text(
                          coins.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            child: Text(
                          "Coins",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900),
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Column(
                      children: [
                        Container(
                            child: Text(
                          money.toString() + '',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            child: Text(
                          "\$",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900),
                        )),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Transform(
                        transform: Matrix4.skewY(-0.05),
                        child: Container(
                          padding: EdgeInsets.all(24),
                          height: 310,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.red,
                                Colors.black,
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'عالم الربح',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'اضغط علي الاعلانات و اربح',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900),
                            ),
                            /* Text(
                                                        posts.data()['username'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w300),
                                                      ),*/
                            SizedBox(height: 6),
                            /*Text(
                                                        posts.data()['email'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w300),
                                                      ),*/
                            SizedBox(height: 6),
                            Text(
                              "قم بتحويل الكوينز لارباح  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "2000 coins =1 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "20000 coins =10 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "100000 coins =50 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "200000 coins =100 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "500000 coins =200 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "1000000 coins =500 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "2000000 coins =1000 \$",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            FlatButton(
                                color: Colors.red,
                                child: Text(
                                  'تحويل ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  if (coins >= 1000) {
                                    setState(() {
                                      money = money + (coins ~/ 1000);
                                      coins = coins % 1000;
                                      //coins = 0;
                                    });
                                    saveData(coins);
                                    saveData2(money);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            new CupertinoAlertDialog(
                                              title: new Text("خطأ "),
                                              content: new Text(
                                                  " يجب ان تحصل علي 1000 كوينز حتي تستطيع التحويل بنجاح"),
                                            ));
                                  }

                                  saveData(coins);
                                  saveData2(money);
                                }),
                            SizedBox(height: 20),
                            /* TextFormField(
                                                        controller: _emailcontroller,
                                                        autocorrect:true,
                                                        decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons.email),

                                                          labelText:  "Enter paypal mail Or phone number",labelStyle:TextStyle(color:Colors.black,fontSize:14,fontWeight:FontWeight.w300),
                                                          enabledBorder: OutlineInputBorder
                                                            (borderSide: BorderSide(color: Colors.pinkAccent)),
                                                          border:OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Colors.white,),
                                                            borderRadius: BorderRadius.circular(16.0),
                                                          ),
                                                        ),
                                                        validator: (value){
                                                          if(value.isEmpty){
                                                            return 'Fill your email or phone';
                                                          }
                                                          if(value.length<9){
                                                            return 'wrong ';
                                                          }

                                                          // return 'Valid Name';
                                                        },
                                                      ),
                                                      */
                            /* Container(
                                                        child:Text('OR')
                                                      ),
                                                      TextFormField(
                                                        controller: _emailcontroller,
                                                        autocorrect:true,
                                                        decoration: InputDecoration(
                                                          prefixIcon: Icon(Icons.email),

                                                          labelText:  " Enter your mobile number  ",
                                                          enabledBorder: OutlineInputBorder
                                                            (borderSide: BorderSide(color: Colors.pinkAccent)),
                                                          border:OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Colors.white,),
                                                            borderRadius: BorderRadius.circular(16.0),
                                                          ),
                                                        ),
                                                        validator: (value){
                                                          if(value.isEmpty){
                                                            return 'Fill your mobile number';
                                                          }
                                                          if(value.length<6){
                                                            return 'wrong number';
                                                          }

                                                          // return 'Valid Name';
                                                        },
                                                      ),*/

                            FlatButton(
                                color: Colors.red,
                                child: Text(
                                  'طلب استلام  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (money < 1) {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            new CupertinoAlertDialog(
                                              title: new Text(" Sorry "),
                                              content: new Text(
                                                  "يجب ان تحصل علي 1 من العملة كحد ادني لطلب الاستلام "),
                                            ));
                                  } else {
                                    sendWhatsApp(
                                        '+9647725256635',
                                        'hello i am using wallpaper and ads app and my money = ' +
                                            money.toString());
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  sendWhatsApp(String phone, String msg) async {
    String url() {
      if (Platform.isAndroid) {
        return 'whatsapp://send?phone=$phone&text=$msg';
        //  return 'whatsapp://wa.me/$phone/?text=${Uri.parse(msg)}';
      } else {
        return 'whatsapp://send?phone=$phone&text=$msg';
        //  return 'whatsapp://send?$phone=phone&text=$msg';
        //   return 'whatsapp://wa.me/$phone&text=$msg';
      }
    }

    await canLaunch(url())
        ? launch(url())
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('there is no whats app in your device')));
  }
}



              //),

              // Container(
              //   color: Color.fromRGBO(41, 30, 83, 1),
              //   padding: const EdgeInsets.only(top:40),
              //   child: CurvedNavigationBar(
              //       color:Colors.indigo[900],
              //       backgroundColor: Color.fromRGBO(41, 30, 83, 1),
              //       //buttonBackgroundColor:Colors.blue,
              //       items:<Widget>[
              //         Icon(Icons.home,size:24,color:Colors.red),
              //         //  Icon(Icons.add_box,size:24,color:Colors.blue),
              //         Icon(Icons.messenger_rounded,size:24,color:Colors.red),
              //         // Icon(Icons.account_circle,size:24,color:Colors.white),
              //       ],
              //
              //       animationCurve:Curves.bounceOut,
              //       onTap:(index) async {
              //         final user = FirebaseAuth.instance.currentUser;
              //         final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              //         String ud=userData['username'];
              //
              //
              //         /* if(index==1)
              //            {
              //              intersitialAd.show();
              //              Navigator.push(
              //                  context,
              //                  MaterialPageRoute(builder: (context) {
              //                return AddPost();
              //              }));
              //         }*/
              //         if(index==1){
              //           intersitialAd.show();
              //           Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatScreen2(ud)));
              //         }
              //
              //       }
              //
              //   ),
              // )


