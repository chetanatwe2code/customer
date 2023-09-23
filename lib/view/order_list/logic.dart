import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/OrderModel.dart';
import '../../repository/order_history_repo.dart';

class OrderHistoryLogic extends GetxController {
  final OrderHistoryRepo orderHistoryRepo;
  OrderHistoryLogic({required this.orderHistoryRepo});


  List<OrderModel> list = [];

  int pageSize = 10;
  int pageKey = 0;
  bool isNext = false;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  bool apiProcess = false;
  getOrder({ bool isNextPage = false }){

    if(isNextPage){
      print("Hello next $isNext");
      if(isNext){
        pageKey += 1;
      }else{
        refreshController.loadComplete();
        return;
      }
    }else{
      apiProcess = true;
      pageKey = 0;
      list.clear();
    }
    orderHistoryRepo.getOrder({
      "search":"",
      "order_id": "",
      "vendor_id":"",
      "category":"",
      "brand":"",
      "status_order": ""
    },"?page=$pageKey&per_page=$pageSize&group=yes").then((value) => {
      if(value.body['results'] != null){

        value.body['results'].forEach((v){
          list.add(OrderModel.fromJson(v));
        }),
        print("value.body['pagination'] ${value.body['pagination']}"),
        if((int.tryParse(value.body['pagination']['next'].toString())??0) > 0){
          isNext = true,
        }else{
          isNext = false,
        },
        if(isNextPage){
          refreshController.loadComplete(),
        }else{
          refreshController.refreshCompleted(),
        },
      },
    }).whenComplete(() => {
      apiProcess = false,
      update(),
    });
  }

}
