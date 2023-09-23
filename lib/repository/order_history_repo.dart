import 'package:get/get.dart';

import '../core/di/api_client.dart';
import '../core/di/api_provider.dart';

class OrderHistoryRepo {
  final ApiClient apiClient;
  OrderHistoryRepo({required this.apiClient});

  Future<Response> getOrder(dynamic body,String query) async{
    return await apiClient.postAPI(ApiProvider.getOrder+query, body) ;
  }

}