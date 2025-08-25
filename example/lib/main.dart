import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _tiktokBusinessSdkPlugin = TiktokBusinessSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _tiktokBusinessSdkPlugin.initTiktokBusinessSdk(
      accessToken: dotenv.env['accessToken'] ?? '',
      appId: dotenv.env['appId'] ?? '',
      ttAppId: dotenv.env['ttAppId'] ?? '',
      openDebug: false,
      enableAutoIapTrack: true,
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _tiktokBusinessSdkPlugin.getPlatformVersion() ??
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
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () {
                _tiktokBusinessSdkPlugin.setIdentify(
                  externalId: '1234567890',
                  externalUserName: 'John Doe',
                  phoneNumber: '1234567890',
                  email: 'john.doe@example.com',
                );
              },
              child: Text('Set Identify'),
            ),
            ElevatedButton(
              onPressed: () {
                _tiktokBusinessSdkPlugin.logout();
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                _tiktokBusinessSdkPlugin.trackTTEvent(
                  event: EventName.achieveLevel,
                );
              },
              child: Text('Track TT Event'),
            ),
            Text('Platform Version: $_platformVersion'),
          ],
        ),
      ),
    );
  }
}
