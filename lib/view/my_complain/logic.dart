import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../model/ComplainModel.dart';

class MyComplainLogic extends GetxController {
  final ApiClient apiClient;
  MyComplainLogic({required this.apiClient});


  RefreshController refreshController = RefreshController(initialRefresh: false);

  List<ComplainModel> list = [];
  bool getProcess = false;
  getComplain() async{
    getProcess = true;
    list.clear();
    update();
   await apiClient.postAPI(ApiProvider.getComplain,{}).then((value) => {
      if(value.body['status'] == true){
        value.body['result'].forEach((v){
          list.add(ComplainModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      getProcess = true,
      update()
    });
  }

}
