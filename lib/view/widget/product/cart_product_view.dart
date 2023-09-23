import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';
import 'package:indiakinursery/utils/price_converter.dart';
import 'package:indiakinursery/utils/string_extensions.dart';
import 'package:indiakinursery/view/widget/toast.dart';
import '../../../core/routes.dart';
import '../../../model/CartModel.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/string_helper.dart';
import '../../cart/increase_decrease_btn.dart';
import '../common_image.dart';

class CartProductView extends StatelessWidget {
  final CartModel? cartModel;
  final Function()? onDecrease;
  final Function()? onIncrease;
  final Function()? deleteCart;
  const CartProductView({Key? key,this.cartModel,this.onIncrease,this.onDecrease,this.deleteCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String productImage = StringHelper.fistValueOfCommaSeparated(value: cartModel?.coverImage ?? cartModel?.allImagesUrl);
    if(productImage.isEmpty){
      productImage = StringHelper.defaultProductImage;
    }

    double height = 85;
    bool isMaxLimitOver = ((cartModel?.cartProductQuantity??0) >= (cartModel?.productStockQuantity??0));
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grayColor(),width: 0.2))
      ),
      padding: const EdgeInsets.only(bottom: 15,top: 15),
      child: InkWell(
        onTap: (){
          Get.toNamed(rsProductDetailPage,
              arguments: {
                "product_id" : cartModel?.productId ?? 0,
                "variant_id":cartModel?.productVerientId ?? 0 });
        },
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: CommonImage(
                    imageUrl: productImage,
                    width: 70,
                    height: 70,
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

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((cartModel?.name ?? "").toCapitalizeFirstLetter(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textColor(),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                Text((cartModel?.verientName ?? "").toCapitalizeFirstLetter(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor(),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IncreaseDecreaseBtn(
                                onDecrease: onDecrease,
                                isDecrease: cartModel?.isDecrease,
                                isIncrease: cartModel?.isIncrease,
                                buttonSize: 30,
                                onIncrease: isMaxLimitOver ? (){
                                  Toast.show(title: "${cartModel?.verientName??0}",toastMessage: "Cart Max Reach".trParams({
                                    "stock" : "${cartModel?.productStockQuantity??0}"
                                  }),isError: true);
                                } :  onIncrease,
                                cartCount: cartModel?.cartProductQuantity,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            if((cartModel?.discount??0)>0)
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  "\u{20B9}${cartModel?.mrp}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.redColor(),
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ),

                            Text(
                              "\u{20B9}${cartModel?.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                                color: AppColors.textColor(),
                                letterSpacing: -0.4,
                              ),
                            ),


                          ],
                        ),
                        Text(
                          "\u{20B9}${PriceConverter.removeDecimalZeroFormat((cartModel?.price??0)*(cartModel?.cartProductQuantity??1))}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.primaryColor(),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
