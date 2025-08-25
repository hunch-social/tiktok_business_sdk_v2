import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiktok_business_sdk_method_channel.dart';

abstract class TiktokBusinessSdkPlatform extends PlatformInterface {
  /// Constructs a TiktokBusinessSdkPlatform.
  TiktokBusinessSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokBusinessSdkPlatform _instance = MethodChannelTiktokBusinessSdk();

  /// The default instance of [TiktokBusinessSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokBusinessSdk].
  static TiktokBusinessSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokBusinessSdkPlatform] when
  /// they register themselves.
  static set instance(TiktokBusinessSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initTiktokBusinessSdk({
    required String accessToken,
    required String appId,
    required String ttAppId,
    bool openDebug = false,
    bool enableAutoIapTrack = true,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> setIdentify({
    required String externalId,
    String? externalUserName,
    String? phoneNumber,
    String? email,
  }) {
    throw UnimplementedError('setIdentify() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<void> trackTTEvent({required EventName event, String? eventId}) {
    throw UnimplementedError('trackTTEvent() has not been implemented.');
  }
}

enum EventName {
  achieveLevel('ACHIEVE_LEVEL'),
  addPaymentInfo('ADD_PAYMENT_INFO'),
  completeTutorial('COMPLETE_TUTORIAL'),
  createGroup('CREATE_GROUP'),
  createRole('CREATE_ROLE'),
  generateLead('GENERATE_LEAD'),
  inAppAdClick('IN_APP_AD_CLICK'),
  inAppAdImpr('IN_APP_AD_IMPR'),
  installApp('INSTALL_APP'),
  joinGroup('JOIN_GROUP'),
  launchApp('LAUNCH_APP'),
  loanApplication('LOAN_APPLICATION'),
  loanApproval('LOAN_APPROVAL'),
  loanDisbursal('LOAN_DISBURSAL'),
  login('LOGIN'),
  rate('RATE'),
  registration('REGISTRATION'),
  search('SEARCH'),
  spendCredits('SPEND_CREDITS'),
  startTrial('START_TRIAL'),
  subscribe('SUBSCRIBE'),
  impressionLevelAdRevenue('IMPRESSION_LEVEL_AD_REVENUE'),
  unlockAchievement('UNLOCK_ACHIEVEMENT');

  final String value;
  const EventName(this.value);

  @override
  String toString() => value;

  static EventName? from(String raw) {
    for (final e in EventName.values) {
      if (e.value == raw) return e;
    }
    return null;
  }
}
