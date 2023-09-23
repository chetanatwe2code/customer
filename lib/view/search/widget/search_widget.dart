import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/search/widget/search_filter.dart';

import '../../../theme/app_colors.dart';

class SearchWidget extends StatefulWidget {
  final String hintText;
  final Function? onTextChanged;
  final Function onClearPressed;
  final Function? onSubmit;
  final Function? onSearch;
  final Function? onFilterChange;
  final bool enableBack;
  final bool isSearching;
  final bool isLarge;
  const SearchWidget({Key? key,this.isSearching=false, this.enableBack=true,required this.hintText,
    required this.onClearPressed,
    this.onSubmit,
    this.onSearch,
    this.isLarge = false,
    this.onTextChanged,this.onFilterChange}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.symmetric(vertical: 5),
      height: widget.isLarge ? 60 : 50,
      alignment: Alignment.center,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: AppColors.whiteColor(), borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  children: [
                    widget.enableBack ?
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ) : const SizedBox(width: 20,),
                    Flexible(
                      child: TextFormField(
                        autofocus: false,
                        controller: controller,
                        onFieldSubmitted: (query) {
                          if(widget.onSubmit != null){
                            widget.onSubmit!(query);
                          }
                        },
                        onChanged: (query) {
                          if(mounted){
                            setState((){});
                          }
                          if(query.isEmpty){
                            if(widget.onTextChanged != null){
                              widget.onClearPressed();
                            }
                          }
                          if(widget.onTextChanged != null){
                            widget.onTextChanged!(query);
                          }
                        },
                        textInputAction: TextInputAction.search,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: widget.isLarge ? 17 : 14
                        ),
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: widget.isLarge ? 17 : 14
                          ),
                          border: InputBorder.none,
                          suffixIcon: (widget.isSearching) ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 17,height: 17,
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          ) :
                          // controller.text.isEmpty ?
                          // const Icon(Icons.search) :
                          IconButton(
                            onPressed: controller.text.isNotEmpty ? (){

                              if(widget.onSearch != null){
                                print("object ${controller.text}");
                                widget.onSearch!(controller.text);
                              }
                              // controller.clear();
                              // if(mounted){
                              //   setState((){});
                              // }
                              // if(widget.onTextChanged != null){
                              //   widget.onClearPressed();
                              // }
                            } : null,
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),),
            SizedBox(width: 5,),
            InkWell(
              onTap: (){
                Get.bottomSheet(
                  SearchFilter(onFilterChange: widget.onFilterChange,sheetHeight: (Get.height),defaultPadding: MediaQuery.of(context).padding.top),
                  isScrollControlled: true,
                  barrierColor: Colors.transparent,
                  isDismissible: false,
                ).then((value) => {
                  widget.onTextChanged!(controller.text),
                  FocusScope.of(context).requestFocus(FocusNode())
                }).catchError((e){
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor(),
                  ),
                  child: Icon(Icons.filter_alt_outlined,color: AppColors.whiteColor(),)),
            )
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.unfocus();
  }
}
