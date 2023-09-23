import 'package:get/get_connect/http/src/response/response.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class NotificationRepo{
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<Response> getNotification() async => await apiClient.getAPI(ApiProvider.getNotification);

}