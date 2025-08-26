import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk_platform_interface.dart';
import 'package:tiktok_business_sdk/tiktok_business_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokBusinessSdkPlatform
    with MockPlatformInterfaceMixin
    implements TiktokBusinessSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<void> initTiktokBusinessSdk({required String accessToken, required String appId, required String ttAppId, bool openDebug = false, bool enableAutoIapTrack = true, bool disableAutoEnhancedDataPostbackEvents = false}) {
    return Future.value();
  }
  
  @override
  Future<void> logout() {
    return Future.value();
  }
  
  @override
  Future<void> setIdentify({required String externalId, String? externalUserName, String? phoneNumber, String? email}) {
    return Future.value();
  }
  
  @override
  Future<void> trackTTEvent({required EventName event, String? eventId}) {
    return Future.value();
  }
}

void main() {
  final TiktokBusinessSdkPlatform initialPlatform = TiktokBusinessSdkPlatform.instance;

  test('$MethodChannelTiktokBusinessSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokBusinessSdk>());
  });

  test('getPlatformVersion', () async {
    TiktokBusinessSdk tiktokBusinessSdkPlugin = TiktokBusinessSdk();
    MockTiktokBusinessSdkPlatform fakePlatform = MockTiktokBusinessSdkPlatform();
    TiktokBusinessSdkPlatform.instance = fakePlatform;

    expect(await tiktokBusinessSdkPlugin.getPlatformVersion(), '42');
  });
}
