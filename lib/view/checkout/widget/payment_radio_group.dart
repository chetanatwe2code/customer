import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';

enum PaymentMethod { cod,payNow }
typedef OnPaymentTab = void Function(PaymentMethod? mode);

class PaymentRadioGroup extends StatefulWidget {
  final PaymentMethod? initialValue;
  final OnPaymentTab? onPaymentTab;
  const PaymentRadioGroup({Key? key,this.initialValue,this.onPaymentTab}) : super(key: key);

  @override
  State<PaymentRadioGroup> createState() => _PaymentRadioGroupState();
}

class _PaymentRadioGroupState extends State<PaymentRadioGroup> {

  PaymentMethod? selected;
  int? id;

  @override
  void initState() {
    super.initState();
    if(widget.initialValue == PaymentMethod.cod){
      selected = PaymentMethod.cod;
      id = 1;
    }if(widget.initialValue == PaymentMethod.payNow){
      selected = PaymentMethod.payNow;
      id = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        InkWell(
          onTap: (){
            selected = PaymentMethod.cod;
            id = 1;
            if(widget.onPaymentTab != null){
              widget.onPaymentTab!(selected!);
            }
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id,
                onChanged: (val) {
                  selected = PaymentMethod.cod;
                  id = 1;
                  if(widget.onPaymentTab != null){
                    widget.onPaymentTab!(selected!);
                  }
                  setState(() {});
                },
              ),
              Text(
                'Cash on delivery'.tr,
                style: TextStyle(
                    color: AppColors.blackColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),

        // 10.verticalSpace,
        //
        // InkWell(
        //   onTap: (){
        //     selected = PaymentMethod.payNow;
        //     id = 2;
        //     if(widget.onPaymentTab != null){
        //       widget.onPaymentTab!(selected!);
        //     }
        //     setState(() {});
        //   },
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       Radio(
        //         value: 2,
        //         groupValue: id,
        //         onChanged: (val) {
        //           selected = PaymentMethod.payNow;
        //           id = 2;
        //           if(widget.onPaymentTab != null){
        //             widget.onPaymentTab!(selected!);
        //           }
        //           setState(() {});
        //         },
        //       ),
        //       Text(
        //         'Pay Now'.tr,
        //         style: TextStyle(
        //             color: AppColors.blackColor(),
        //             fontSize: 17.sp,
        //             fontWeight: FontWeight.w500
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
