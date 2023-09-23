import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/search/widget/search_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/search_controller.dart';
import '../../theme/app_colors.dart';
import '../login/view.dart';
import '../widget/api_error/not_data.dart';
import '../widget/product/grid_product_view.dart';
import '../widget/product/shimmer/grid_product_view.dart';
import '../widget/toast.dart';

// how can use onDestroy in StatelessWidget
class SearchPage extends StatefulWidget {
  final bool fromBaseScreen;
  const SearchPage({Key? key,this.fromBaseScreen=false}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

 final SearchLogic controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isLarge = isLargeScreen(media);
   // WidgetsBinding.instance.addPostFrameCallback((_){
      //controller.clearList(notify: false);
      controller.searchProduct();
    //});
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        bottomNavigationBar: widget.fromBaseScreen ? null : Get.find<HomeLogic>().getBottomBar(),
        body: Padding(
          padding: isLarge ? const EdgeInsets.only(top: 20, left: 50, right: 50) : const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: GetBuilder<SearchLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                children: [

                  SearchWidget(hintText: "Search".tr,
                      enableBack: !widget.fromBaseScreen,
                      isLarge: isLarge,
                      onClearPressed: () {
                    controller.clearList(notify: true);
                  },
                      onSearch: (String key){
                        controller.searchProduct(keyword: key.trim());
                      },
                      isSearching: logic.isSearching,
                      onTextChanged: (String key) {
                        print("ABC::_ $key");
                        if(key.isEmpty){
                          controller.searchProduct();
                        }else{
                          controller.searchProduct(keyword: key.trim());
                        }
                  }),

                  // if(logic.keyword.isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 5,bottom: 5),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text("Search result".tr,
                  //         style: TextStyle(color: AppColors.textColor()),),
                  //         10.horizontalSpace,
                  //         Text("${logic.keyword}",
                  //           style: TextStyle(color: AppColors.textColor(),
                  //           fontWeight: FontWeight.bold),),
                  //       ],
                  //     ),
                  //   ),

                  if(logic.isSearching)...[
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ProductShimmerView(itemCount: 10),
                      ),
                    ),
                  ]else...[
                    if(logic.list.isNotEmpty)...[
                      Flexible(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: WaterDropHeader(
                            waterDropColor: Colors.transparent,
                            idleIcon: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor(),
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.refresh, color: Theme
                                  .of(context)
                                  .primaryColor),
                            ),
                          ),
                          footer: CustomFooter(
                            builder: (BuildContext context, LoadStatus? mode) {
                              Widget body;
                              if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              } else {
                                body = Container();
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: body,
                              );
                            },
                          ),
                          onRefresh: () {
                            logic.searchProduct(keyword: logic.keyword);
                          },
                          onLoading: () {
                            logic.searchProduct(isNextPage: true,keyword: logic.keyword);
                          },
                          controller: logic.refreshController,
                          child: StaggeredGridView.countBuilder(
                            itemCount: logic.list.length,
                            crossAxisCount: getGridCount(media),
                            padding: const EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: isLarge ? 15 : 10,
                            mainAxisSpacing: isLarge ? 15 : 10,
                            staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(1),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductView(
                                productModel: logic.list[index],
                                addToCart: () {
                                  logic.list[index].isIncrease = true;
                                  logic.update();
                                  Get.find<CartController>().addToCart(
                                      productId: logic.list[index].id ?? 0,
                                      variantId: logic.list[index].productVerientId ?? 0,
                                      quantity: (logic.list[index].cartCount ??
                                          0) + 1).then((value) =>
                                  {
                                    logic.list[index].isIncrease = false,
                                    logic.list[index].cartCount =
                                        (logic.list[index].cartCount ?? 0) + 1,
                                    logic.update(),
                                    Toast.show(toastMessage: "Go to cart and checkout".tr,iconData: Icons.check_circle)
                                  }).catchError((e) {
                                    logic.list[index].isIncrease = false;
                                    logic.update();
                                  });
                                },
                                onIncrease: () {
                                  logic.list[index].isIncrease = true;
                                  logic.update();
                                  Get.find<CartController>().updateQuantity(
                                      productId: logic.list[index].id ?? 0,
                                      variantId: logic.list[index].productVerientId ?? 0,
                                      quantity: (logic.list[index].cartCount ??
                                          0) + 1).then((value) =>
                                  {
                                    logic.list[index].isIncrease = false,
                                    logic.list[index].cartCount =
                                        (logic.list[index].cartCount ?? 0) + 1,
                                    logic.update(),
                                  }).catchError((e) {
                                    logic.list[index].isIncrease = false;
                                    logic.update();
                                  });
                                },
                                onDecrease: () {
                                  if ((logic.list[index].cartCount ?? 0) < 1) {
                                    return;
                                  }
                                  logic.list[index].isDecrease = true;
                                  logic.update();
                                  Get.find<CartController>().updateQuantity(
                                      productId: logic.list[index].id ?? 0,
                                      variantId: logic.list[index].productVerientId ?? 0,
                                      quantity: (logic.list[index].cartCount ??
                                          0) - 1).then((value) =>
                                  {
                                    logic.list[index].isDecrease = false,
                                    logic.list[index].cartCount =
                                        (logic.list[index].cartCount ?? 0) - 1,
                                    logic.update(),
                                  }).catchError((e) {
                                    logic.list[index].isDecrease = false;
                                    logic.update();
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ]else...[
                      const Flexible(child: NoData(iconData: Icons.search_off,))
                    ],
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.find<SearchLogic>().clearFilter(notify: false);
    super.dispose();
  }
}
