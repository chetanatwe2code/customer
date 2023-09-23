import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/view/checkout/widget/payment_radio_group.dart';
import 'package:indiakinursery/view/widget/toast.dart';
import '../../../../controller/account_controller.dart';
import '../../../../theme/app_colors.dart';
import '../../../controller/checkout_logic.dart';
import '../../widget/common_material_button.dart';
import '../../widget/input_field/common_input_field.dart';
import 'address_radio_group.dart';

class ConfirmOrder extends StatefulWidget {
  final double? paddingTop;
  const ConfirmOrder({Key? key, this.paddingTop})
      : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  PaymentMethod paymentMode = PaymentMethod.cod;
  AddressModel addressModel = AddressModel(
    name: Get
        .find<AccountLogic>()
        .userModel
        ?.firstName ?? "",
    email: Get
        .find<AccountLogic>()
        .userModel
        ?.email ?? "",
    number: Get
        .find<AccountLogic>()
        .userModel
        ?.phoneNo ?? "",
    image: Get
        .find<AccountLogic>()
        .userModel
        ?.image ?? "",
    address: Get
        .find<AccountLogic>()
        .userModel
        ?.address ?? "",
    city: Get
        .find<AccountLogic>()
        .userModel
        ?.city ?? "",
    pin: Get
        .find<AccountLogic>()
        .userModel
        ?.pincode ?? "",
  );

  @override
  void initState() {
    super.initState();
    nameController.text = addressModel.name ?? "";
    emailController.text = addressModel.email ?? "";
    numberController.text = addressModel.number ?? "";
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.whiteColor(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: Colors.blueGrey.withOpacity(0.1),
          ),
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [

                    SizedBox(height: (widget.paddingTop ?? 1) * 1.7,),

                    /// Header
                    SizedBox(
                      height: kToolbarHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Delivery Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),

                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      // border: Border.all(color: Colors.red,width: 0.1)
                                    ),
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColors.redColor(),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AddressRadioGroup(
                      callback: (addressModel) {
                        setState(() {
                          this.addressModel = AddressModel(
                              city: addressModel.city,
                              pin: addressModel.pin,
                              address: addressModel.address,
                              saveAsDefault: addressModel.saveAsDefault,
                              email: this.addressModel.email,
                              image: this.addressModel.image,
                              lat: this.addressModel.lat,
                              long: this.addressModel.long,
                              name: this.addressModel.name,
                              number: this.addressModel.number
                          );
                        });
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 12),
                      child: CommonInputField(
                        hintText: 'Name',
                        labelText: "Name",
                        onTextChanged: (str) {
                          addressModel.name = str;
                        },
                        textController: nameController,
                        keyboardType: TextInputType.name,
                        suffixIcon: const Icon(Icons.person),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 12),
                      child: CommonInputField(
                        hintText: 'number',
                        labelText: "number",
                        onTextChanged: (str) {
                          addressModel.number = str;
                        },
                        textController: numberController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        suffixIcon: const Icon(Icons.phone),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 12),
                      child: CommonInputField(
                        hintText: 'email',
                        labelText: "email",
                        enabled: false,
                        onTextChanged: (str) {
                          addressModel.email = str;
                        },
                        textController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.email),
                      ),
                    ),

                    SizedBox(height: 10,),


                    /// Header
                    SizedBox(
                      height: kToolbarHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payment Mode",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),

                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(2.0),
                                //     child: Icon(
                                //       Icons.clear, color: AppColors.textColor(),),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    PaymentRadioGroup(
                      onPaymentTab: (mode) {
                        setState(() {
                          paymentMode = mode ?? PaymentMethod.cod;
                        });
                      },
                      initialValue: PaymentMethod.cod,
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                constraints: const BoxConstraints(
                  minHeight: 0,
                  maxHeight: 90
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<CheckoutLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<CheckoutLogic>(
                          assignId: true,
                          builder: (logic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(height: 10,),

                                if(logic.notAvailable)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text("Service Unavailable".trParams({
                                      "pinCode": logic.addressModel?.pin ?? ""
                                    }),
                                      style: TextStyle(
                                          color: AppColors.redColor(),
                                        fontSize: 12
                                      ),),
                                  ),

                                if(logic.notAvailableIds.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text("Some ${"Service Unavailable".trParams({
                                      "pinCode": logic.addressModel?.pin ?? ""
                                    })}",
                                      style: TextStyle(
                                          color: AppColors.redColor()
                                      ),),
                                  ),
                              ],
                            );
                          },
                        ),

                        CommonMaterialButton(
                          text: "Proceed".tr,
                          color: AppColors.primary,
                          fontColor: Colors.white,
                          //isEnable: !logic.notAvailable && logic.notAvailableIds.isEmpty,
                          isLoading: logic.orderPlaceProcess,
                          onTap: () {
                            if (addressModel.address?.isEmpty ?? true) {
                              Toast.show(
                                  toastMessage: "Enter Delivery Address".tr,
                                  isError: true);
                            } else if (addressModel.city?.isEmpty ?? true) {
                              Toast.show(toastMessage: "Enter city".tr,
                                  isError: true);
                            } else if (addressModel.pin?.isEmpty ?? true) {
                              Toast.show(toastMessage: "Enter Pin-Code".tr,
                                  isError: true);
                            } else if (addressModel.pin?.length != 6) {
                              Toast.show(
                                  toastMessage: "Enter Valid pin-code".tr,
                                  isError: true);
                            } else if (nameController.text.isEmpty) {
                              Toast.show(toastMessage: "Enter Name".tr,
                                  isError: true);
                            }
                            // else if (emailController.text.isEmpty) {
                            //   Toast.show(toastMessage: "Enter Email".tr,
                            //       isError: true);
                            // }
                            else if (numberController.text.isEmpty) {
                              Toast.show(
                                  toastMessage: "Enter Phone Number".tr,
                                  isError: true);
                            } else {
                              logic.addressModel = addressModel;
                              logic.mode = paymentMode;
                              logic.serviceAvailable(checkWithCheckout: true);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
