import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/account_controller.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/view/widget/common_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/search_controller.dart';
import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../account/widget/profile_menu_item.dart';
import '../login/view.dart';
import '../widget/api_error/no_internet.dart';
import '../widget/cetegory/horizontal_category.dart';
import '../widget/cetegory/simmer/horizontal_category_simmer.dart';
import '../widget/product/horizontal_product_view.dart';
import '../widget/product/shimmer/grid_product_view.dart';
import '../widget/toast.dart';

double horizontalPadding = 15;

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bool isSmall = !isLargeScreen(media);
    return _buildSmallScreen(context,media,isSmall);
  }

  Widget _buildSmallScreen(BuildContext context, Size size,bool isSmall){
    double height = 288;
    double horizontalPadding = isSmall ? 15 : 80;
    double width = size.width > 400 ? 190 : ((size.width / 2) - (horizontalPadding));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor()),
      child: SafeArea(
        child: GetBuilder<AccountLogic>(
          assignId: true,
          builder: (logic) {
            return Scaffold(
              key: controller.key,
              backgroundColor: Colors.blueGrey.withOpacity(0.1),
              drawer: logic.userModel == null ? null : Drawer(
                  backgroundColor: AppColors.whiteColor(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      InkWell(
                        // onTap: (){
                        //   controller.key.currentState?.closeDrawer();
                        //   Get.toNamed(rsAccountPage);
                        // },
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor(),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              30.verticalSpace,
                              CommonImage(
                                imageUrl: logic.userModel?.image ?? "",
                                assetPlaceholder: appUser,
                                width: 50,
                                height: 50,
                                radius: 25,
                              ),
                              20.verticalSpace,
                              Text(
                                (("${logic.userModel?.firstName ?? ""} ${logic
                                    .userModel?.lastName ?? ""}").trim()),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17
                                ),),
                              5.verticalSpace,
                              Text(logic.userModel?.email ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14
                                ),),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: 10,
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),

                      ProfileMenuItem(
                        title: "Edit Profile".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          controller.key.currentState?.closeDrawer(),
                          Get.toNamed(rsEditProfilePage)
                        },
                        icon: FlutterRemix.edit_2_line,
                      ),

                      ProfileMenuItem(
                        title: "Change Password".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          controller.key.currentState?.closeDrawer(),
                          Get.toNamed(rsChangePasswordPage)
                        },
                        icon: FlutterRemix.lock_password_line,
                      ),


                      ProfileMenuItem(
                        title: "Order History".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          controller.key.currentState?.closeDrawer(),
                          Get.toNamed(rsOrderHistoryPage),
                        },
                        icon: FlutterRemix.file_list_2_line,
                      ),

                      ProfileMenuItem(
                        title: "My Complain".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          controller.key.currentState?.closeDrawer(),
                          Get.toNamed(rsMyComplainPage),
                        },
                        icon: Icons.contact_support_outlined,
                      ),

                      // ProfileMenuItem(
                      //   title: "Subscription".tr,
                      //   hPadding: 15,
                      //   onClick: () =>
                      //   {
                      //     controller.key.currentState?.closeDrawer(),
                      //   },
                      //   icon: Icons.wallet_membership,
                      // ),

                      ProfileMenuItem(
                        title: "Help & Support".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          controller.key.currentState?.closeDrawer(),
                          Get.toNamed(rsSupportPage)
                        },
                        icon: Icons.support_agent_outlined,
                      ),

                      ProfileMenuItem(
                        title: "Logout".tr,
                        hPadding: 15,
                        onClick: () =>
                        {
                          Get.find<AccountLogic>().logout()
                        },
                        isLast: true,
                        icon: Icons.exit_to_app,
                      ),

                    ],
                  )
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  Get.find<HomeLogic>().pullRefresh();
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [

                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      toolbarHeight: kToolbarHeight.h,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(appLogo3, width: 150),
                          //Text("Home".tr),
                        ],
                      ),
                      leading: IconButton(
                        icon: CommonImage(
                          imageUrl: logic.userModel?.image ?? "",
                          assetPlaceholder: appUser,
                          width: 30,
                          height: 30,
                          radius: 30,
                        ),
                        onPressed: () {
                          controller.key.currentState?.openDrawer();
                        },
                      ),
                      actions: [

                        // IconButton(onPressed: () {
                        //   Get.toNamed(rsSearchPage);
                        // },
                        //     icon: Icon(
                        //       Icons.search, color: AppColors.iconColor(),)),
                        GetBuilder<HomeLogic>(
                          assignId: true,
                          builder: (logic) {
                            return SizedBox(
                              width: 50,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(onPressed: () {
                                    Get.toNamed(rsNotificationPage);
                                  },
                                      icon: Icon(Icons.notifications,
                                        color: AppColors.iconColor(),)),
                                  if((logic.notificationCount > 0))
                                    Positioned(
                                      right: 15,
                                      top: 10,
                                      child: Column(
                                        children: [

                                          if((logic.notificationCount <
                                              100))...[
                                            Container(
                                              width: 13,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                color: Theme
                                                    .of(context)
                                                    .errorColor,
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${logic.notificationCount
                                                    .value}",
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white
                                                ),),
                                            ),
                                          ] else
                                            ...[

                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment: Alignment.center,
                                              ),

                                            ],


                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.r),
                        child: GetBuilder<HomeLogic>(
                          assignId: true,
                          builder: (logic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                if(logic.noInternet)...[
                                  SizedBox(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 3,),
                                  NoInternet(
                                    retry: () {
                                      logic.pullRefresh();
                                    },
                                  ),

                                ] else
                                  ...[

                                    /// Banner

                                    if(logic.getBannerProcess)...[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 40),
                                        child: Shimmer.fromColors(
                                            baseColor: AppColors
                                                .shimmerBaseColor(),
                                            highlightColor: AppColors
                                                .shimmerHighlightColor(),
                                            child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width / 3,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: horizontalPadding),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                color: AppColors
                                                    .shimmerBaseColor(),
                                              ),
                                            )),
                                      )
                                    ] else
                                      ...[
                                        if(logic.bannerList.isNotEmpty)...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 40),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: logic
                                                          .bannerList
                                                          .length > 1 ? 0 : 10),
                                                  child: CarouselSlider.builder(
                                                    itemCount: logic.bannerList
                                                        .length,
                                                    options: CarouselOptions(
                                                        autoPlay: logic
                                                            .bannerList
                                                            .length > 1,
                                                        aspectRatio: isSmall ? 3.0 : 4.0,
                                                        enlargeCenterPage: true,
                                                        autoPlayInterval: const Duration(
                                                            seconds: 3),
                                                        autoPlayAnimationDuration: const Duration(
                                                            milliseconds: 800),
                                                        autoPlayCurve: Curves
                                                            .fastOutSlowIn,
                                                        initialPage: 0,
                                                        viewportFraction: logic
                                                            .bannerList.length >
                                                            1
                                                            ? 0.8
                                                            : 1,
                                                        onPageChanged: (index,
                                                            reason) {
                                                          logic.setIndex(index);
                                                        }
                                                    ),
                                                    itemBuilder: (context,
                                                        index,
                                                        realIdx) {
                                                      return CommonImage(
                                                          width: size.width,
                                                          fit: BoxFit.fitHeight,
                                                          imageUrl: logic
                                                              .bannerList[index]
                                                              .bannerImageUrl ??
                                                              "");
                                                    },
                                                  ),
                                                ),

                                                if(logic.bannerList.length > 1)
                                                  Positioned(
                                                    bottom: -30,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: logic.bannerList
                                                          .map((url) {
                                                        int index = logic
                                                            .bannerList
                                                            .indexOf(url);
                                                        return Container(
                                                          width: 8.0,
                                                          height: 8.0,
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 2.0),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            color: logic
                                                                .bannerCurrentIndex ==
                                                                index
                                                                ? const Color
                                                                .fromRGBO(
                                                                0, 0, 0, 0.9)
                                                                : const Color
                                                                .fromRGBO(
                                                                0, 0, 0, 0.4),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),)
                                              ],),
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                          //   child: CommonImage(
                                          //     imageUrl: "https://digianafresh.com/images/media/2022/04/J5Am108202.jpg",
                                          //     width: Get.width * 2,
                                          //     fit: BoxFit.fitWidth,
                                          //     radius: 10.r,
                                          //   ),
                                          // ),
                                        ],
                                      ],

                                    /// Top Band
                                    // if(logic.bandList.isNotEmpty)
                                    //  Padding(
                                    //    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                    //    child: Text("Top Brand",
                                    //      style: TextStyle(
                                    //          color: AppColors.textColor(),
                                    //          fontWeight: FontWeight.bold,
                                    //          fontSize: 16.sp
                                    //      ),),
                                    //  ),
                                    //  10.verticalSpace,
                                    //  if(logic.getBrandProcess)...[
                                    //    Padding(
                                    //      padding: EdgeInsets.only(left: horizontalPadding),
                                    //      child: HorizontalBrandShimmer(width: (Get.width/4.8).r),
                                    //    ),
                                    //  ]else...[
                                    //  if(logic.bandList.isNotEmpty)
                                    //    SizedBox(
                                    //      height: (Get.width/4.2) - horizontalPadding,
                                    //      child: ListView.builder(
                                    //        itemCount: logic.bandList.length,
                                    //        scrollDirection: Axis.horizontal,
                                    //        padding: EdgeInsets.only(left: horizontalPadding),
                                    //        itemBuilder: (context, index) {
                                    //          return HorizontalBrand(
                                    //            width: (Get.width/4.2) - horizontalPadding,
                                    //            brandModel: logic.bandList[index],);
                                    //        },),
                                    //    ),
                                    //  ],


                                    /// Category
                                    if(logic.categoryList.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalPadding),
                                        child: Text("Product Category".tr,
                                          style: TextStyle(
                                              color: AppColors.textColor(),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),),
                                      ),
                                    10.verticalSpace,

                                    if(logic.getBrandProcess)...[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: horizontalPadding),
                                        child: const HorizontalCategorySimmer(),
                                      ),
                                    ] else
                                      ...[
                                        if(logic.categoryList.isNotEmpty)
                                          SizedBox(
                                            height: isSmall ? ((Get.width / 3.2)) / 2 : 100,
                                            child: ListView.builder(
                                              itemCount: logic.categoryList
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.only(
                                                  left: horizontalPadding),
                                              itemBuilder: (context, index) {
                                                return HorizontalCategory(
                                                  width: (isSmall ? (Get.width / 3.2) : 200) - horizontalPadding,
                                                  categoryModel: logic
                                                      .categoryList[index],);
                                              },),
                                          ),
                                      ],

                                    30.verticalSpace,

                                    /// Latest product
                                    if(logic.getProductProcess)...[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalPadding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text("Latest Product".tr,
                                              style: TextStyle(
                                                  color: AppColors.textColor(),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14
                                              ),),
                                            TextButton(onPressed: null,
                                              child: Text("view all".tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),),)
                                          ],
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: horizontalPadding),
                                        child: const ProductShimmerView(),
                                      )
                                    ] else
                                      ...[

                                        // Featured product
                                        if(logic.featuredList.isNotEmpty)...[
                                          Column(
                                            children: [
                                              10.verticalSpace,
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: horizontalPadding),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text("Featured Product".tr,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .textColor(),
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 14
                                                      ),),
                                                    TextButton(onPressed: () {
                                                      if(Get.isRegistered<SearchLogic>()){
                                                        Get.find<SearchLogic>().productTypeName = ProductType.featured.name;
                                                      }
                                                      Get.find<HomeLogic>().toIndex(2,notify: false);
                                                      Get.offAllNamed(rsBasePage);
                                                      // Get.toNamed(rsSearchPage,
                                                      //     arguments: {
                                                      //       "productType": ProductType
                                                      //           .featured.name
                                                      //     });
                                                    },
                                                      child: Text("view all".tr,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 14
                                                        ),),)
                                                  ],
                                                ),
                                              ),
                                              5.verticalSpace,
                                              SizedBox(
                                                height: logic.featuredList
                                                    .isNotEmpty ? height : 0,
                                                child: ListView.builder(
                                                  itemCount: logic.featuredList
                                                      .length,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: horizontalPadding),
                                                  itemBuilder: (context,
                                                      index) {
                                                    return SizedBox(
                                                        width: width,
                                                        child: HorizontalProductView(
                                                          width: width,
                                                          height: height,
                                                          addToCart: () {
                                                            if ((logic
                                                                .featuredList[index]
                                                                .productStockQuantity ??
                                                                0) < 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic
                                                                .featuredList[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .addToCart(
                                                                productId: logic
                                                                    .featuredList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .featuredList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .featuredList[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic
                                                                  .featuredList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .featuredList[index]
                                                                      .cartCount ??
                                                                      0) +
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                              Toast.show(
                                                                  toastMessage: "Added In Cart"
                                                                      .tr,
                                                                  iconData: Icons
                                                                      .check_circle)
                                                            }).catchError((e) {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onIncrease: () {
                                                            if ((logic
                                                                .featuredList[index]
                                                                .productStockQuantity ??
                                                                0) < (logic
                                                                .featuredList[index]
                                                                .cartCount ??
                                                                0) + 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic
                                                                .featuredList[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .featuredList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .featuredList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .featuredList[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic
                                                                  .featuredList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .featuredList[index]
                                                                      .cartCount ??
                                                                      0) + 1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onDecrease: () {
                                                            if ((logic
                                                                .featuredList[index]
                                                                .cartCount ??
                                                                0) <
                                                                1) {
                                                              return;
                                                            }
                                                            logic
                                                                .featuredList[index]
                                                                .isDecrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .featuredList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .featuredList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .featuredList[index]
                                                                    .cartCount ??
                                                                    0) - 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isDecrease =
                                                              false,
                                                              logic
                                                                  .featuredList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .featuredList[index]
                                                                      .cartCount ??
                                                                      0) -
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .featuredList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic
                                                                  .featuredList[index]
                                                                  .isDecrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          productModel: logic
                                                              .featuredList[index],
                                                          formHome: true,));
                                                  },),
                                              ),
                                            ],
                                          ),


                                          // 10.verticalSpace,
                                          // StaggeredGridView.countBuilder(
                                          //   itemCount: logic.list.length,
                                          //   crossAxisCount: 2,
                                          //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                          //   physics: const NeverScrollableScrollPhysics(),
                                          //   shrinkWrap: true,
                                          //   crossAxisSpacing: 10,
                                          //   mainAxisSpacing: 10,
                                          //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                                          //   itemBuilder: (BuildContext context, int index) {
                                          //     return ProductView(
                                          //       productModel: logic.list[index],
                                          //       addToCart: () {
                                          //         if((logic.list[index].productStockQuantity??0) < 1){
                                          //           Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                          //           return;
                                          //         }
                                          //         logic.list[index].isIncrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().addToCart(
                                          //             productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) + 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isIncrease = false,
                                          //           logic.list[index].cartCount =
                                          //               (logic.list[index].cartCount ?? 0) +
                                          //                   1,
                                          //           logic.update(),
                                          //           Toast.show(toastMessage: "Added In Cart".tr,iconData: Icons.check_circle)
                                          //         }).catchError((e) {
                                          //           logic.list[index].isIncrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //       onIncrease: () {
                                          //         if((logic.list[index].productStockQuantity??0) < (logic.list[index]
                                          //             .cartCount ??
                                          //             0) + 1){
                                          //           Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                          //           return;
                                          //         }
                                          //         logic.list[index].isIncrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().updateQuantity(productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) + 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isIncrease = false,
                                          //           logic.list[index].cartCount = (logic.list[index].cartCount ?? 0) + 1,
                                          //           logic.update(),
                                          //         }).catchError((e) {
                                          //           logic.list[index].isIncrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //       onDecrease: () {
                                          //         if ((logic.list[index].cartCount ?? 0) <
                                          //             1) {
                                          //           return;
                                          //         }
                                          //         logic.list[index].isDecrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().updateQuantity(
                                          //             productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) - 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isDecrease = false,
                                          //           logic.list[index].cartCount =
                                          //               (logic.list[index].cartCount ?? 0) -
                                          //                   1,
                                          //           logic.update(),
                                          //         }).catchError((e) {
                                          //           logic.list[index].isDecrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //     );
                                          //   },
                                          // ),
                                        ],

                                        // Latest Product
                                        if(logic.list.isNotEmpty)...[
                                          10.verticalSpace,
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: horizontalPadding),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text("Latest Product".tr,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .textColor(),
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 14
                                                      ),),
                                                    TextButton(onPressed: () {
                                                      if(Get.isRegistered<SearchLogic>()){
                                                        Get.find<SearchLogic>().productTypeName = ProductType.latest.name;
                                                      }
                                                      Get.find<HomeLogic>().toIndex(2,notify: false);
                                                      Get.offAllNamed(rsBasePage);
                                                      // Get.toNamed(rsSearchPage,
                                                      //     arguments: {
                                                      //       "productType": ProductType
                                                      //           .latest.name
                                                      //     });
                                                    },
                                                      child: Text("view all".tr,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 14
                                                        ),),)
                                                  ],
                                                ),
                                              ),
                                              5.verticalSpace,
                                              SizedBox(
                                                height: logic.list.isNotEmpty
                                                    ? height
                                                    : 0,
                                                child: ListView.builder(
                                                  itemCount: logic.list.length,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: horizontalPadding),
                                                  itemBuilder: (context,
                                                      index) {
                                                    return SizedBox(
                                                        width: width,
                                                        child: HorizontalProductView(
                                                          width: width,
                                                          height: height,
                                                          isLargeScreen: isSmall == true,
                                                          addToCart: () {
                                                            if ((logic
                                                                .list[index]
                                                                .productStockQuantity ??
                                                                0) < 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic.list[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .addToCart(
                                                                productId: logic
                                                                    .list[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .list[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .list[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic.list[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic.list[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .list[index]
                                                                      .cartCount ??
                                                                      0) +
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                              Toast.show(
                                                                  toastMessage: "Added In Cart"
                                                                      .tr,
                                                                  iconData: Icons
                                                                      .check_circle)
                                                            }).catchError((e) {
                                                              logic.list[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onIncrease: () {
                                                            if ((logic
                                                                .list[index]
                                                                .productStockQuantity ??
                                                                0) < (logic
                                                                .list[index]
                                                                .cartCount ??
                                                                0) + 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic.list[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .list[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .list[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .list[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic.list[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic.list[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .list[index]
                                                                      .cartCount ??
                                                                      0) + 1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic.list[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onDecrease: () {
                                                            if ((logic
                                                                .list[index]
                                                                .cartCount ??
                                                                0) <
                                                                1) {
                                                              return;
                                                            }
                                                            logic.list[index]
                                                                .isDecrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .list[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .list[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .list[index]
                                                                    .cartCount ??
                                                                    0) - 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic.list[index]
                                                                  .isDecrease =
                                                              false,
                                                              logic.list[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .list[index]
                                                                      .cartCount ??
                                                                      0) -
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .trendingList
                                                                      .length; k++){
                                                                if(logic
                                                                    .trendingList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .list[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .trendingList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .trendingList[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic.list[index]
                                                                  .isDecrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          productModel: logic
                                                              .list[index],
                                                          formHome: true,));
                                                  },),
                                              ),
                                            ],
                                          ),
                                        ],

                                        // Trending Product
                                        if(logic.trendingList.isNotEmpty)...[
                                          const SizedBox(height: 10,),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: horizontalPadding),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text("Trending Product".tr,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .textColor(),
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 16
                                                      ),),
                                                    TextButton(onPressed: () {
                                                      if(Get.isRegistered<SearchLogic>()){
                                                        Get.find<SearchLogic>().productTypeName = ProductType.trending.name;
                                                      }
                                                      Get.find<HomeLogic>().toIndex(2,notify: false);
                                                      Get.offAllNamed(rsBasePage);
                                                      // Get.toNamed(rsSearchPage,
                                                      //     arguments: {
                                                      //       "productType": ProductType
                                                      //           .trending.name
                                                      //     });
                                                    },
                                                      child: Text("view all".tr,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 15
                                                        ),),)
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5,),
                                              SizedBox(
                                                height: logic.trendingList
                                                    .isNotEmpty ? height : 0,
                                                child: ListView.builder(
                                                  itemCount: logic.trendingList
                                                      .length,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: horizontalPadding),
                                                  itemBuilder: (context,
                                                      index) {
                                                    return SizedBox(
                                                        width: width,
                                                        child: HorizontalProductView(
                                                          width: width,
                                                          height: height,
                                                          isLargeScreen: isSmall == true,
                                                          addToCart: () {
                                                            if ((logic
                                                                .trendingList[index]
                                                                .productStockQuantity ??
                                                                0) < 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic
                                                                .trendingList[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .addToCart(
                                                                productId: logic
                                                                    .trendingList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .trendingList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .trendingList[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic
                                                                  .trendingList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .trendingList[index]
                                                                      .cartCount ??
                                                                      0) +
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                              Toast.show(
                                                                  toastMessage: "Added In Cart"
                                                                      .tr,
                                                                  iconData: Icons
                                                                      .check_circle)
                                                            }).catchError((e) {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onIncrease: () {
                                                            if ((logic
                                                                .trendingList[index]
                                                                .productStockQuantity ??
                                                                0) < (logic
                                                                .trendingList[index]
                                                                .cartCount ??
                                                                0) + 1) {
                                                              Toast.show(
                                                                  toastMessage: "Out of Stock"
                                                                      .tr,
                                                                  isError: true);
                                                              return;
                                                            }
                                                            logic
                                                                .trendingList[index]
                                                                .isIncrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .trendingList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .trendingList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .trendingList[index]
                                                                    .cartCount ??
                                                                    0) + 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isIncrease =
                                                              false,
                                                              logic
                                                                  .trendingList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .trendingList[index]
                                                                      .cartCount ??
                                                                      0) + 1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) + 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isIncrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          onDecrease: () {
                                                            if ((logic
                                                                .trendingList[index]
                                                                .cartCount ??
                                                                0) <
                                                                1) {
                                                              return;
                                                            }
                                                            logic
                                                                .trendingList[index]
                                                                .isDecrease =
                                                            true;
                                                            logic.update();
                                                            Get.find<
                                                                CartController>()
                                                                .updateQuantity(
                                                                productId: logic
                                                                    .trendingList[index]
                                                                    .id ?? 0,
                                                                variantId: logic
                                                                    .trendingList[index]
                                                                    .productVerientId ??
                                                                    0,
                                                                quantity: (logic
                                                                    .trendingList[index]
                                                                    .cartCount ??
                                                                    0) - 1,
                                                                fromHome: true)
                                                                .then((value) =>
                                                            {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isDecrease =
                                                              false,
                                                              logic
                                                                  .trendingList[index]
                                                                  .cartCount =
                                                                  (logic
                                                                      .trendingList[index]
                                                                      .cartCount ??
                                                                      0) -
                                                                      1,

                                                              /// find and update count in anther list
                                                              for(int k = 0; k <
                                                                  logic.list
                                                                      .length; k++){
                                                                if(logic.list[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic.list[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .list[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              for(int k = 0; k <
                                                                  logic
                                                                      .featuredList
                                                                      .length; k++){
                                                                if(logic
                                                                    .featuredList[k]
                                                                    .productVerientId ==
                                                                    logic
                                                                        .trendingList[index]
                                                                        .productVerientId){
                                                                  logic
                                                                      .featuredList[k]
                                                                      .cartCount =
                                                                      (logic
                                                                          .featuredList[k]
                                                                          .cartCount ??
                                                                          0) - 1
                                                                }
                                                              },
                                                              logic.update(),
                                                            }).catchError((e) {
                                                              logic
                                                                  .trendingList[index]
                                                                  .isDecrease =
                                                              false;
                                                              logic.update();
                                                            });
                                                          },
                                                          productModel: logic
                                                              .trendingList[index],
                                                          formHome: true,));
                                                  },),
                                              ),
                                            ],
                                          ),


                                          // 10.verticalSpace,
                                          // StaggeredGridView.countBuilder(
                                          //   itemCount: logic.list.length,
                                          //   crossAxisCount: 2,
                                          //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                          //   physics: const NeverScrollableScrollPhysics(),
                                          //   shrinkWrap: true,
                                          //   crossAxisSpacing: 10,
                                          //   mainAxisSpacing: 10,
                                          //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                                          //   itemBuilder: (BuildContext context, int index) {
                                          //     return ProductView(
                                          //       productModel: logic.list[index],
                                          //       addToCart: () {
                                          //         if((logic.list[index].productStockQuantity??0) < 1){
                                          //           Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                          //           return;
                                          //         }
                                          //         logic.list[index].isIncrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().addToCart(
                                          //             productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) + 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isIncrease = false,
                                          //           logic.list[index].cartCount =
                                          //               (logic.list[index].cartCount ?? 0) +
                                          //                   1,
                                          //           logic.update(),
                                          //           Toast.show(toastMessage: "Added In Cart".tr,iconData: Icons.check_circle)
                                          //         }).catchError((e) {
                                          //           logic.list[index].isIncrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //       onIncrease: () {
                                          //         if((logic.list[index].productStockQuantity??0) < (logic.list[index]
                                          //             .cartCount ??
                                          //             0) + 1){
                                          //           Toast.show(toastMessage: "Out of Stock".tr,isError: true);
                                          //           return;
                                          //         }
                                          //         logic.list[index].isIncrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().updateQuantity(productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) + 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isIncrease = false,
                                          //           logic.list[index].cartCount = (logic.list[index].cartCount ?? 0) + 1,
                                          //           logic.update(),
                                          //         }).catchError((e) {
                                          //           logic.list[index].isIncrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //       onDecrease: () {
                                          //         if ((logic.list[index].cartCount ?? 0) <
                                          //             1) {
                                          //           return;
                                          //         }
                                          //         logic.list[index].isDecrease = true;
                                          //         logic.update();
                                          //         Get.find<CartController>().updateQuantity(
                                          //             productId: logic.list[index].id ?? 0,
                                          //             variantId: logic.list[index].productVerientId ?? 0,
                                          //             quantity: (logic.list[index]
                                          //                 .cartCount ??
                                          //                 0) - 1, fromHome: true).then((
                                          //             value) =>
                                          //         {
                                          //           logic.list[index].isDecrease = false,
                                          //           logic.list[index].cartCount =
                                          //               (logic.list[index].cartCount ?? 0) -
                                          //                   1,
                                          //           logic.update(),
                                          //         }).catchError((e) {
                                          //           logic.list[index].isDecrease = false;
                                          //           logic.update();
                                          //         });
                                          //       },
                                          //     );
                                          //   },
                                          // ),
                                        ]
                                      ],
                                    const SizedBox(height: 20,),
                                  ],
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double minHeight;
  double maxHeight;

  SliverDelegate(
      {required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != minHeight ||
        oldDelegate.minExtent != maxHeight || child != oldDelegate.child;
  }
}
