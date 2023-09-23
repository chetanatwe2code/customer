import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/cart_controller.dart';
import '../../theme/app_colors.dart';
import '../widget/api_error/not_found.dart';
import '../widget/product/grid_product_view.dart';
import '../widget/product/shimmer/grid_product_view.dart';
import '../widget/toast.dart';
import 'logic.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProductLogic>().getProduct();
    return Container(
      color: AppColors.whiteColor(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        appBar: AppBar(title: Text((Get.find<ProductLogic>().appBarTitle ?? "Product".tr).toCapitalizeFirstLetter())),
        body: GetBuilder<ProductLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(logic.apiProcess)...[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: const ProductShimmerView(itemCount: 10),
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
                              padding: const EdgeInsets.all(20),
                              child: body,
                            );
                          },
                        ),
                        onRefresh: () {
                          logic.getProduct();
                        },
                        onLoading: () {
                          logic.getProduct(isNextPage: true);
                        },
                        controller: logic.refreshController,
                        child: StaggeredGridView.countBuilder(
                          itemCount: logic.list.length,
                          crossAxisCount: 2,
                          padding: EdgeInsets.all(10.r),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(1),
                          itemBuilder: (BuildContext context, int index) {
                            return ProductView(
                              productModel: logic.list[index],
                              addToCart: () {
                                if((logic.list[index].productStockQuantity??0) < 1){
                                  Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                  return;
                                }
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
                                  Toast.show(toastMessage: "Added In Cart".tr,iconData: Icons.check_circle)
                                }).catchError((e) {
                                  logic.list[index].isIncrease = false;
                                  logic.update();
                                });
                              },
                              onIncrease: () {
                                if((logic.list[index].productStockQuantity??0) < (logic.list[index]
                                    .cartCount ??
                                    0) + 1){
                                  Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                  return;
                                }
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
                    ),
                  ]else...[
                    (Get.height/3).verticalSpace,
                    const NotFound(),
                  ],

                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
