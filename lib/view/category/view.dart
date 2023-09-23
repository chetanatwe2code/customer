import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/home_controller.dart';
import 'package:indiakinursery/controller/search_controller.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/widget/common_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import '../login/view.dart';
import 'logic.dart';

class CategoryPage extends GetView<CategoryLogic> {
  final bool fromBaseScreen;
  const CategoryPage({super.key,this.fromBaseScreen=false});

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<CategoryLogic>()){
      Get.lazyPut(() => CategoryLogic(apiClient: Get.find()));
    }
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    controller.initData();
    return Scaffold(
      appBar: AppBar(title: Text("Category".tr)),
      bottomNavigationBar: fromBaseScreen ? null : Get.find<HomeLogic>().getBottomBar(),
      body: isSmall ? _buildSmallScreen() : _buildLargeScreen(),
    );
  }

  Widget _buildLargeScreen(){
    return GetBuilder<CategoryLogic>(
      assignId: true,
      builder: (logic) {
        bool isNotEmpty = logic.listCategory?.isNotEmpty??false;
        return Column(
          crossAxisAlignment: isNotEmpty ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [

            if(isNotEmpty)...[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border(right: BorderSide(
                              width: 1, color: Color(0xFFE1E1E1)))
                        //   boxShadow: boxShadow(),
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: logic.listCategory?.length,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              logic.setSelectedCategory(logic.listCategory![index]);
                            },
                            child: CategoryItem(
                              title: logic.listCategory![index].category??"",
                              icon: logic.listCategory![index].image??"",
                              isSelected: logic.listCategory![index].id == logic.selectedCategory?.id,
                            ),
                          );
                        },
                      ),
                    ),

                    Expanded(child:
                    logic.getChildCategoryProcess ?
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 5,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor(),
                              highlightColor: AppColors.shimmerHighlightColor(),
                              enabled: true,
                              child: const ListTile(
                                title: Text("Searching..", maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                trailing: Icon(Icons.navigate_next),
                              )
                          );
                        }
                    ) :
                    ListView.builder(
                      itemCount: logic.childCategory.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text((logic.childCategory[index].category??"").toCapitalizeFirstLetter(),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 10.sp
                              ),
                              overflow: TextOverflow.ellipsis),
                          trailing: Icon(Icons.navigate_next,size: 24.h,),
                          onTap: () {
                            if(Get.isRegistered<SearchLogic>()){
                              Get.find<SearchLogic>().categoryFromCategory = logic.childCategory[index].id;
                            }
                            Get.find<HomeLogic>().toIndex(2,notify: false);
                            Get.offAllNamed(rsBasePage);
                            //Get.toNamed(rsSearchPage);
                          },
                        );
                      },
                    )),
                  ],
                ),
              )
            ]else...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not Found".tr,
                    style: TextStyle(color: AppColors.textColor()),),
                ],
              ),
            ]
          ],
        );
      },
    );
  }

  Widget _buildSmallScreen(){
    return GetBuilder<CategoryLogic>(
      assignId: true,
      builder: (logic) {
        bool isNotEmpty = logic.listCategory?.isNotEmpty??false;
        return Column(
          crossAxisAlignment: isNotEmpty ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: isNotEmpty ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [

            if(isNotEmpty)...[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border(right: BorderSide(
                              width: 1, color: Color(0xFFE1E1E1)))
                        //   boxShadow: boxShadow(),
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: logic.listCategory?.length,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              logic.setSelectedCategory(logic.listCategory![index]);
                            },
                            child: CategoryItem(
                              title: logic.listCategory![index].category??"",
                              icon: logic.listCategory![index].image??"",
                              isSelected: logic.listCategory![index].id == logic.selectedCategory?.id,
                            ),
                          );
                        },
                      ),
                    ),

                    Expanded(child:
                    logic.getChildCategoryProcess ?
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 5,
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor(),
                              highlightColor: AppColors.shimmerHighlightColor(),
                              enabled: true,
                              child: const ListTile(
                                title: Text("Searching..", maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                trailing: Icon(Icons.navigate_next),
                              )
                          );
                        }
                    ) :
                    ListView.builder(
                      itemCount: logic.childCategory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(logic.childCategory[index].category??"", maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            if(Get.isRegistered<SearchLogic>()){
                              Get.find<SearchLogic>().categoryFromCategory = logic.childCategory[index].id;
                            }
                            Get.find<HomeLogic>().toIndex(2,notify: false);
                            Get.offAllNamed(rsBasePage);
                            //Get.toNamed(rsSearchPage);
                          },
                        );
                      },
                    )),
                  ],
                ),
              )
            ]else...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not Found".tr,
                    style: TextStyle(color: AppColors.textColor()),),
                ],
              ),
            ]
          ],
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  const CategoryItem(
      {Key? key, required this.title, required this.icon, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 2,
            color: isSelected ? AppColors.primary : AppColors.whiteColor(),
          ),
          top: BorderSide(
            width: 2,
            color: AppColors.whiteColor(),
          ),
          bottom: BorderSide(
            width: 2,
            color: AppColors.whiteColor(),
          ),
          left: BorderSide(
            width: 2,
            color: AppColors.whiteColor(),
          ),
        ),
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CommonImage(
                    imageUrl: icon,
                    fit: BoxFit.cover,
                    assetPlaceholder: appCategory,
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? AppColors.primary : null,
                    )),
              ),
            ]),
      ),
    );
  }
}
