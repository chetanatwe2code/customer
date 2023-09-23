import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/di/get_di.dart' as di;

class VerificationRepo {
  final ApiClient apiClient;
  VerificationRepo({required this.apiClient});

  Future<Response> verifyEmail(dynamic body) async => await apiClient.postAPI(ApiProvider.userVerify,body,useHeader: false);

  Future<Response> resentOtp(dynamic body,bool isForgot) async => await apiClient.postAPI(isForgot?ApiProvider.userForgotPassword:ApiProvider.userRegister,body,useHeader: false);

  saveLoginData(String token) async{
    await di.init();
    await apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken, token);
    await apiClient.sharedPreferences.setBool(ApiProvider.preferencesIsLogin, true);
  }

}