import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/di/get_di.dart' as di;

class SignUpRepo{
  final ApiClient apiClient;
  SignUpRepo({required this.apiClient});

  Future<Response> signUp(dynamic body) async => await apiClient.postAPI(ApiProvider.userRegister, body,useHeader: false);

  saveLoginData(String token) async{
    await di.init();
    await apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken, token);
    await apiClient.sharedPreferences.setBool(ApiProvider.preferencesIsLogin, true);
  }
}