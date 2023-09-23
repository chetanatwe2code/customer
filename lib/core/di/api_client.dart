import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_provider.dart';

class ApiClient extends GetConnect implements GetxService{
  String? token;
  final String apkBaseUrl;
  Map<String,String>? _mainHeaders;
  final SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences,required this.apkBaseUrl}){
    updateServer(apkBaseUrl);
    httpClient.timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(ApiProvider.preferencesToken);
    _mainHeaders = { "user_token" : "$token" };
  }

  updateServer(String baseUrl){
    httpClient.baseUrl = baseUrl;
  }

  updateHeader(String token){
    this.token = token;
    _mainHeaders = { "user_token" : token };
  }

  static const String noInternetMessage = 'Please Check Your Connection';
  static const int errorCode = -101;
  static const int noInternetCode = -1;

  Future<Response<dynamic>> getAPI(String url, {Map<String, dynamic>? query, Map<String, String>? headers, bool useHeader = true}) async {
    try {
      return await _handleResponse(await get(url, headers: useHeader ? headers ?? _mainHeaders : null),"\n<>_______________url::<$url>_______________headers::<${useHeader ? headers ?? _mainHeaders : null}>_______________query::<$query>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> postAPI(String? url, dynamic body, {Map<String, dynamic>? query,Map<String, String>? headers,bool useHeader = true}) async {
    try {
      return _handleResponse(await post(url, body,headers: useHeader ? headers ?? _mainHeaders : null),"\n<>_______________url::<$url>_______________headers::<${useHeader ? headers ?? _mainHeaders : null}>_______________body::<$body>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> putAPI(String url, dynamic body, {Map<String, dynamic>? query,Map<String, String>? headers,bool useHeader = true}) async {
    try {
      return _handleResponse(await put(url,body,headers: useHeader ? headers ?? _mainHeaders : null,),"\n<>_______________url::<$url>_______________headers::<${useHeader ? headers ?? _mainHeaders : null}>_______________body::<$body>_______________<>\n");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> _handleResponse(Response response,String test) async {
    print("$test\n");
    print("\n<>*******************${response.body}*******************<>\n");
    if (response.status.hasError) {
      print("response.status ${response.status}");
      if (response.status.connectionError) {
        throw Exception(noInternetMessage);
      }
      throw Exception("Internal Server Error");
    }
    return response;
  }
}