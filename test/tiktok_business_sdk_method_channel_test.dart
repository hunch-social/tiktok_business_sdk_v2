import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTiktokBusinessSdk platform = MethodChannelTiktokBusinessSdk();
  const MethodChannel channel = MethodChannel('tiktok_business_sdk');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        log.add(methodCall);
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  // The access token is the Events API credential; it used to be compiled into
  // the host app so this channel could forward it. Asserting the WHOLE argument
  // map, not just the keys we expect to be present, is the point: an extra
  // `accessToken` key reappearing here means the secret is back in the app.
  test('initTiktokBusinessSdk forwards every argument and no access token', () async {
    await platform.initTiktokBusinessSdk(appId: 'app_1', ttAppId: 'tt_1');

    expect(log.length, 1);
    expect(log.single.method, 'initTiktokBusinessSdk');
    expect(log.single.arguments, <String, dynamic>{
      'appId': 'app_1',
      'ttAppId': 'tt_1',
      'openDebug': false,
      'enableAutoIapTrack': true,
      'disableAutoEnhancedDataPostbackEvents': false,
    });
  });

  test('initTiktokBusinessSdk carries the optional flags when they are set', () async {
    await platform.initTiktokBusinessSdk(
      appId: 'app_1',
      ttAppId: 'tt_1',
      openDebug: true,
      enableAutoIapTrack: false,
      disableAutoEnhancedDataPostbackEvents: true,
    );

    expect(log.single.arguments, <String, dynamic>{
      'appId': 'app_1',
      'ttAppId': 'tt_1',
      'openDebug': true,
      'enableAutoIapTrack': false,
      'disableAutoEnhancedDataPostbackEvents': true,
    });
  });
}
