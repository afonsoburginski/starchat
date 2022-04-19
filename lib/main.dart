//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'dart:core';
import 'package:starchat/Configs/Dbkeys.dart';
import 'package:starchat/Configs/Enum.dart';
import 'package:starchat/Configs/app_constants.dart';
import 'package:starchat/Screens/splash_screen/splash_screen.dart';
import 'package:starchat/Services/Providers/BroadcastProvider.dart';
import 'package:starchat/Services/Providers/AvailableContactsProvider.dart';
import 'package:starchat/Services/Providers/GroupChatProvider.dart';
import 'package:starchat/Services/Providers/LazyLoadingChatProvider.dart';
import 'package:starchat/Services/Providers/Observer.dart';
import 'package:starchat/Services/Providers/StatusProvider.dart';
import 'package:starchat/Services/Providers/TimerProvider.dart';
import 'package:starchat/Services/Providers/currentchat_peer.dart';
import 'package:starchat/Services/Providers/seen_provider.dart';
import 'package:starchat/Services/localization/demo_localization.dart';
import 'package:starchat/Services/localization/language_constants.dart';
import 'package:starchat/Screens/homepage/homepage.dart';
import 'package:starchat/Services/Providers/DownloadInfoProvider.dart';
import 'package:starchat/Services/Providers/call_history_provider.dart';
import 'package:starchat/Services/Providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  if (DESIGN_TYPE == Themetype.messenger) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            Color(0XFFFFFFFF), //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
  }

  WidgetsFlutterBinding.ensureInitialized();
  if (IsBannerAdShow == true ||
      IsInterstitialAdShow == true ||
      IsVideoAdShow == true) {
    MobileAds.instance.initialize();
  }

  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  binding.renderView.automaticSystemUiAdjustment = false;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(OverlaySupport(child: starchatWrapper()));
  });
}

class starchatWrapper extends StatefulWidget {
  const starchatWrapper({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _starchatWrapperState state =
        context.findAncestorStateOfType<_starchatWrapperState>()!;
    state.setLocale(newLocale);
  }

  @override
  _starchatWrapperState createState() => _starchatWrapperState();
}

class _starchatWrapperState extends State<starchatWrapper> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseGroupServices firebaseGroupServices = FirebaseGroupServices();
    final FirebaseBroadcastServices firebaseBroadcastServices =
        FirebaseBroadcastServices();
    if (this._locale == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      );
    } else {
      return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Splashscreen(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder:
                      (context, AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.hasData) {
                      return MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderMESSAGESforBROADCASTCHATPAGE()),
                          //---
                          ChangeNotifierProvider(
                              create: (_) => StatusProvider()),
                          ChangeNotifierProvider(
                              create: (_) => TimerProvider()),
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderMESSAGESforGROUPCHAT()),
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderMESSAGESforLAZYLOADINGCHAT()),

                          ChangeNotifierProvider(
                              create: (_) => AvailableContactsProvider()),
                          ChangeNotifierProvider(create: (_) => Observer()),
                          Provider(create: (_) => SeenProvider()),
                          ChangeNotifierProvider(
                              create: (_) => DownloadInfoprovider()),
                          ChangeNotifierProvider(create: (_) => UserProvider()),
                          ChangeNotifierProvider(
                              create: (_) =>
                                  FirestoreDataProviderCALLHISTORY()),
                          ChangeNotifierProvider(
                              create: (_) => CurrentChatPeer()),
                        ],
                        child: StreamProvider<List<BroadcastModel>>(
                          initialData: [],
                          create: (BuildContext context) =>
                              firebaseBroadcastServices.getBroadcastsList(
                                  snapshot.data!.getString(Dbkeys.phone) ?? ''),
                          child: StreamProvider<List<GroupModel>>(
                            initialData: [],
                            create: (BuildContext context) =>
                                firebaseGroupServices.getGroupsList(
                                    snapshot.data!.getString(Dbkeys.phone) ??
                                        ''),
                            child: MaterialApp(
                              builder: (BuildContext? context, Widget? widget) {
                                ErrorWidget.builder =
                                    (FlutterErrorDetails errorDetails) {
                                  return CustomError(
                                      errorDetails: errorDetails);
                                };

                                return widget!;
                              },
                              theme: ThemeData(
                                  fontFamily: FONTFAMILY_NAME,
                                  primaryColor: starchatgreen,
                                  primaryColorLight: starchatgreen,
                                  indicatorColor: starchatLightGreen),
                              title: Appname,
                              debugShowCheckedModeBanner: false,

                              home: Homepage(
                                prefs: snapshot.data!,
                                currentUserNo:
                                    snapshot.data!.getString(Dbkeys.phone),
                                isSecuritySetupDone: snapshot.data!.getString(
                                            Dbkeys.isSecuritySetupDone) ==
                                        null
                                    ? false
                                    : ((snapshot.data!
                                                .getString(Dbkeys.phone) ==
                                            null)
                                        ? false
                                        : (snapshot.data!.getString(Dbkeys
                                                    .isSecuritySetupDone) ==
                                                snapshot.data!
                                                    .getString(Dbkeys.phone))
                                            ? true
                                            : false),
                              ),

                              // ignore: todo
                              //TODO:---- All localizations settings----
                              locale: _locale,
                              supportedLocales: supportedlocale,
                              localizationsDelegates: [
                                DemoLocalization.delegate,
                                GlobalMaterialLocalizations.delegate,
                                GlobalWidgetsLocalizations.delegate,
                                GlobalCupertinoLocalizations.delegate,
                              ],
                              localeResolutionCallback:
                                  (locale, supportedLocales) {
                                for (var supportedLocale in supportedLocales) {
                                  if (supportedLocale.languageCode ==
                                          locale!.languageCode &&
                                      supportedLocale.countryCode ==
                                          locale.countryCode) {
                                    return supportedLocale;
                                  }
                                }
                                return supportedLocales.first;
                              },
                              //--- All localizations settings ended here----
                            ),
                          ),
                        ),
                      );
                    }
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_) => UserProvider()),
                      ],
                      child: MaterialApp(
                          theme: ThemeData(
                              fontFamily: FONTFAMILY_NAME,
                              primaryColor: starchatgreen,
                              primaryColorLight: starchatgreen,
                              indicatorColor: starchatLightGreen),
                          debugShowCheckedModeBanner: false,
                          home: Splashscreen()),
                    );
                  });
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splashscreen(),
            );
          });
    }
  }
}

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      width: 0,
    );
  }
}
