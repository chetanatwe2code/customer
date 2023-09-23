import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../controller/search_controller.dart';
import '../../../theme/app_colors.dart';

class SearchFilter extends StatefulWidget {
  final Function? onFilterChange;
  final double sheetHeight;
  final double defaultPadding;

  const SearchFilter({Key? key,
    this.onFilterChange,
    this.sheetHeight = 300,
    this.defaultPadding = 0})
      : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

enum ShortBy { aToZ, zToA, priceLToH, priceHToL, ratingLtoH, ratingHtoL }

getShortName(String name){
  if(name == ShortBy.aToZ.name){
    return "Product : A-Z";
  }
  if(name == ShortBy.zToA.name){
    return "Product : Z-A";
  }
  if(name == ShortBy.priceLToH.name){
    return "Price : High to Low";
  }
  if(name == ShortBy.priceHToL.name){
    return "Price : Low to High";
  }
  if(name == ShortBy.ratingLtoH.name){
    return "Rating : High to Low";
  }
  if(name == ShortBy.ratingHtoL.name){
    return "Rating : Low to High";
  }
}

class _SearchFilterState extends State<SearchFilter> {
  SearchLogic controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getCategory();
    controller.checkFilterAdded(notify: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          color: AppColors.whiteColor()),
      height: widget.sheetHeight + MediaQuery
          .of(context)
          .padding
          .top,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// Header
          Container(
            padding: EdgeInsets.only(top: widget.defaultPadding),
            height: kToolbarHeight + widget.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.clear,
                            color: AppColors.textColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Footer
          SizedBox(
            height: kToolbarHeight,
            child: GetBuilder<SearchLogic>(
              assignId: true,
              builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 40,),
                          SizedBox(
                            height: 35,
                            child: TextButton(
                                onPressed: logic.filterIsAdded
                                    ? () {
                                  logic.clearFilter();

                                }
                                    : null,
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: const Text("Clear Filter")),
                          ),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                                onPressed: logic.filterIsAdded
                                    ? () {
                                  logic.applyFilter();
                                  Navigator.pop(context);
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: const Text("Apply")),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Body
          SizedBox(
            height: (widget.sheetHeight -
                ((kToolbarHeight * 2) + widget.defaultPadding)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<SearchLogic>(
                    assignId: true,
                    builder: (logic) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          priceFilter(),
                          categoryFilter(),
                          ratingFilter(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<ShortBy>> _addDividersAfterItems(List<ShortBy> type) {
    List<DropdownMenuItem<ShortBy>> menuItems = [];
    for (var item in type) {
      menuItems.addAll(
        [
          DropdownMenuItem<ShortBy>(
            value: item,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(getShortName(item.name))
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != type.last)
            const DropdownMenuItem<ShortBy>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  Widget priceFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          /// FILTER BY
          GetBuilder<SearchLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Short By",
                    style: TextStyle(
                        color: AppColors.textColor(),
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme
                                .of(context)
                                .dividerColor
                                .withOpacity(0.5),
                            width: 0.2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10))),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: _addDividersAfterItems(ShortBy.values),
                        value: logic.selectedValue,
                        onChanged: (value) {
                          logic.selectedValue = value;
                          if(value != null){
                            logic.changeFilterIsAdded(true,notify: false);
                          }
                          logic.update();
                        },
                        isExpanded: true,
                        hint: const Text(
                          'Short By',
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 12.5),
                          elevation: 8,
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          ),

          /// PRICE RANGE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Filter by price range",
                style: TextStyle(
                    color: AppColors.textColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              GetBuilder<SearchLogic>(
                assignId: true,
                builder: (logic) {
                  return logic.invalidMaxPrice
                      ? Text(
                    "max price must be grater then min price",
                    style: TextStyle(color: AppColors.redColor()),
                  )
                      : const SizedBox();
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme
                                .of(context)
                                .hintColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\u{20b9}",
                            style: TextStyle(
                                fontSize: 20, color: AppColors.textColor()),
                          ),
                          SizedBox(width: 5,),
                          Flexible(
                            child: TextField(
                              maxLines: 1,
                              controller: controller.minPriceController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(color: AppColors.textColor()),
                              onChanged: (e) {
                                controller.checkFilterAdded();
                                if (controller
                                    .maxPriceController.text.isNotEmpty) {
                                  controller.setMaxError();
                                }
                              },
                              decoration: const InputDecoration(
                                  hintText: "Min.",
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                                  focusedBorder: InputBorder.none,
                                  counterText: "",
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme
                                .of(context)
                                .hintColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\u{20b9}",
                            style: TextStyle(
                                fontSize: 20, color: AppColors.textColor()),
                          ),
                          SizedBox(width: 5,),
                          Flexible(
                            child: TextField(
                              maxLines: 1,
                              controller: controller.maxPriceController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(color: AppColors.textColor()),
                              onChanged: (e) {
                                controller.checkFilterAdded();
                                if (e.isNotEmpty) {
                                  controller.setMaxError();
                                } else {
                                  controller.setMaxError(error: false);
                                }
                              },
                              decoration: const InputDecoration(
                                  hintText: "Max.",
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                                  focusedBorder: InputBorder.none,
                                  counterText: "",
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GetBuilder<SearchLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              /// Category
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "Filter by Category",
                        style: TextStyle(
                            color: AppColors.textColor(),
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    width: 0.5),
                                right: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    width: 0.5),
                                top: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    width: 0.5),
                                bottom: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    width: 0.5)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )
                          // borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          style: TextStyle(color: AppColors.textColor()),
                          onChanged: (s) {
                            logic.searchCategory(s);
                          },
                          controller: logic.categoryController,
                          decoration: InputDecoration(
                            hintText: "Search by name...",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.clearCategoryText();
                                },
                                icon: const Icon(Icons.clear)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    constraints:
                    const BoxConstraints(minHeight: 20, maxHeight: 240),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: logic.sortedCategories.isEmpty
                        ? null
                        : BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: Theme
                                .of(context)
                                .hintColor,
                            width: 0.5),
                        right: BorderSide(
                            color: Theme
                                .of(context)
                                .hintColor,
                            width: 0.5),
                        bottom: BorderSide(
                            color: Theme
                                .of(context)
                                .hintColor,
                            width: 0.5),
                      ),
                    ),
                    child: Scrollbar(
                      thickness: 10,
                      //thumbVisibility: logic.sortedCategories.isNotEmpty,
                      radius: const Radius.circular(5),
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: logic.sortedCategories.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: logic.checkIfExist(
                                        logic.sortedCategories[index].id),
                                    onChanged: (bool? value) {
                                      if (value ?? false) {
                                        logic.addSelectedCategory(
                                            logic.sortedCategories[index].id);
                                      } else {
                                        logic.removeSelectedCategory(
                                            logic.sortedCategories[index].id);
                                      }
                                      logic.checkFilterAdded();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    logic.sortedCategories[index].category ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget ratingFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GetBuilder<SearchLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                "Filter by Ratting",
                style: TextStyle(
                    color: AppColors.textColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 20,),
              //RatingBar(rating: 1,size: 40,),
              RatingBar.builder(
                initialRating: logic.rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                const Icon(
                  Icons.star,
                  color: AppColors.ratingColor,
                ),
                onRatingUpdate: (rating) {
                  logic.updateRating(rating);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
