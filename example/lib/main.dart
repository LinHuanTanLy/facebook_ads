import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:facebook_ads/facebook_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _facebookAdsPlugin = FacebookAds();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _facebookAdsPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  initPlatformState();
                },
                child: Text('Running on: $_platformVersion\n'),
              ),
              MaterialButton(
                onPressed: () {
                  _facebookAdsPlugin.clearUserData();
                },
                child: const Text('clearUserData'),
              ),
              MaterialButton(
                onPressed: () {
                  _facebookAdsPlugin.logEvent("ly_test",
                      parameters: {
                        "name": "ly",
                        "age": "18",
                      },
                      valueToSum: 18);
                },
                child: const Text('logEvent'),
              ),
              MaterialButton(
                onPressed: () {
                  _facebookAdsPlugin
                      .setUserID("10086")
                      .then((value) => debugPrint("setUserID--$value"));
                },
                child: const Text('setUserID'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
