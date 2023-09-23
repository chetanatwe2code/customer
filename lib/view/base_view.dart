import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/cart/view.dart';
import 'package:indiakinursery/view/search/view.dart';
import 'package:indiakinursery/view/widget/count_badge.dart';
import '../controller/account_controller.dart';
import '../controller/home_controller.dart';
import '../core/routes.dart';
import 'category/view.dart';
import 'home/view.dart';
import 'login/view.dart';
import 'widget/show_animated_dialog.dart';


class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {


  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoryPage(fromBaseScreen: true,),
    SearchPage(fromBaseScreen: true,),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    Get.find<HomeLogic>().setBaseIndex(index);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<AccountLogic>().getAccountDetails();
  }

  Future<bool> _onWillPop() async {
    return await showAnimatedDialog(
        context,
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  left: 0,
                  top: 5,
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Are you sure?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Do you want to exit an App",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              Get.offAll(rsDefaultPage);
                            },
                            child: Text(
                              'YES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<HomeLogic>(
        assignId: true,
        builder: (logic) {
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: isSmall ? kToolbarHeight : kToolbarHeight * 1.3,
              child: BottomNavigationBar(
                onTap: _onItemTapped,
                iconSize: isSmall ? 24 : 28,
                selectedItemColor: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
                selectedFontSize: isSmall ? 12 : 14,
                unselectedFontSize: isSmall ? 11 : 13,
                type: BottomNavigationBarType.fixed,
                //showUnselectedLabels: false,
                currentIndex: logic.selectedIndex,
                //showSelectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(FlutterRemix.home_fill),
                      label: "Home".tr,
                      backgroundColor: Colors.green
                  ),

                  BottomNavigationBarItem(
                      icon: const Icon(FlutterRemix.dashboard_fill),
                      label: "Category".tr,
                      backgroundColor: Colors.green
                  ),

                  BottomNavigationBarItem(
                      icon: const Icon(Icons.search),
                      label: "Search".tr,
                      backgroundColor: Colors.green
                  ),

                  BottomNavigationBarItem(
                      icon: GetBuilder<HomeLogic>(
                        assignId: true,
                        builder: (logic) {
                          return CountBadge(
                              icon: FlutterRemix.shopping_basket_2_fill,
                              size: isSmall ? 24 : 28,
                              count: logic
                                  .cartCount
                                  .value);
                        },
                      ),
                      label: "Cart".tr,
                      backgroundColor: Colors.green
                  ),

                ],
              ),
            ),
            body: _widgetOptions[logic.selectedIndex],
          );
        },
      ),
    );
  }
}

