import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';
import '../core/di/get_di.dart' as di;

class LoginRepo {
  final ApiClient apiClient;
  LoginRepo({required this.apiClient});

  Future<Response> login(dynamic body) async => await apiClient.postAPI(ApiProvider.userLogin, body,useHeader: false);
  Future<Response> socialLogin(dynamic body) async => await apiClient.postAPI(ApiProvider.socialLogin, body,useHeader: false);

  saveLoginData(String token) async{
    await di.init();
    await apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken, token);
    await apiClient.sharedPreferences.setBool(ApiProvider.preferencesIsLogin, true);
  }

}