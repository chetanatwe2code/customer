import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class ForgotPasswordRepo {
  final ApiClient apiClient;
  ForgotPasswordRepo({required this.apiClient});

  Future<Response> forgotPassword(dynamic body) async => await apiClient.postAPI(ApiProvider.userForgotPassword,body,useHeader: false);

}