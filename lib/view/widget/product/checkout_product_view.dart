import 'package:flutter/material.dart';
import 'package:indiakinursery/utils/price_converter.dart';
import 'package:indiakinursery/utils/string_extensions.dart';

import '../../../theme/app_colors.dart';
import '../../../model/CartModel.dart';
import '../../../utils/assets.dart';
import '../../../utils/string_helper.dart';
import '../common_image.dart';

class CheckoutProductView extends StatelessWidget {
  final CartModel? cartModel;
  final Function()? onDecrease;
  final Function()? onIncrease;
  final Function()? deleteCart;

  const CheckoutProductView(
      {Key? key, this.cartModel, this.onDecrease, this.onIncrease, this.deleteCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String productImage = StringHelper.fistValueOfCommaSeparated(value: cartModel?.coverImage ?? cartModel?.allImagesUrl);
    if (productImage.isEmpty) {
      productImage = StringHelper.defaultProductImage;
    }
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: AppColors.whiteColor(),
      //   boxShadow: boxShadow(),
      // ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.grayColor(),width: 0.2))
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: CommonImage(
                  imageUrl: productImage,
                  width: 80,
                  height: 80,
                  assetPlaceholder: appProductDemo,
                ),
              ),

              InkWell(
                onTap: (){
                  if(deleteCart != null){
                    deleteCart!();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white70
                  ),
                  width: 28,
                  height: 28,
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      if((cartModel?.isDeleting ?? false))...[
                        const SizedBox(
                            width: (24),
                            height: (24),
                            child: CircularProgressIndicator(strokeWidth: 1,)),
                      ]else...[
                        SizedBox(
                            width: (24),
                            height: (24),
                            child: Icon(Icons.delete_forever,color: AppColors.redColor(),)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        (cartModel?.verientName ?? "").toCapitalizeFirstLetter(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textColor(),
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                  ],
                ),

                if((cartModel?.discount??0)>0)
                  createRow(title: "Discount ",
                      value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((((cartModel?.mrp??0)*(cartModel?.discount??0))/100)*(cartModel?.cartProductQuantity??0))}",
                      subValue: "${PriceConverter.getSingleDigit((cartModel?.discount ?? 0),)}%"),

                if((cartModel?.gst??0)>0)
                  createRow(title: "GST ",
                      value: "\u{20B9}${PriceConverter.getGst(gst: cartModel?.gst,price: cartModel?.price,count: cartModel?.cartProductQuantity)}",
                  subValue: "${cartModel?.gst}%"),

                // if((cartModel?.gst??0)>0)
                //   createRow(title: "GST ",
                //       value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((((cartModel?.price??0)*(cartModel?.gst??0))/100)*(cartModel?.cartProductQuantity??0))}",
                //       subValue: "${PriceConverter.getSingleDigit((cartModel?.gst ?? 0),)}%"),

                createRow(title: "Price ",
                    value: "\u{20B9}${PriceConverter.removeDecimalZeroFormat((cartModel?.price??0)*(cartModel?.cartProductQuantity??1))}",
                    subValue: "${cartModel?.cartProductQuantity} × \u{20B9}${(cartModel?.price ?? 0)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  createRow({required String title ,required String value, String? subValue }){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(
            width: 65,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.textColor(),
                letterSpacing: -0.4,
              ),
            ),
          ),

          SizedBox(
            child: Text(
              ":-",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.textColor(),
                letterSpacing: -0.4,
              ),
            ),
          ),

          const SizedBox(width: 10,),

          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.primaryColor(),
              letterSpacing: -0.4,
            ),
          ),

          if(subValue?.isNotEmpty??false)...[
            const SizedBox(width: 5,),
            SizedBox(
              child: Text(
                "($subValue)",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.textColor(),
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
