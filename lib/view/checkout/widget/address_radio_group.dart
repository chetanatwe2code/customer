import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/controller/account_controller.dart';

import '../../../../theme/app_colors.dart';
import '../../../controller/checkout_logic.dart';
import '../../widget/input_field/common_input_field.dart';

enum AddressMode { address, alterNative }

class AddressModel {
  String? name;
  String? email;
  String? number;
  String? image;
  String? address;
  String? pin;
  String? city;
  String? lat;
  String? long;
  bool saveAsDefault;
  AddressModel(
      {this.name, this.email, this.image, this.number, this.address, this.long, this.city, this.lat, this.pin, this.saveAsDefault = false });
}

class AddressRadioGroup extends StatefulWidget {
  final AddressMode? initialValue;
  final Function(AddressModel addressModel)? callback;

  const AddressRadioGroup({Key? key, this.initialValue, this.callback})
      : super(key: key);

  @override
  State<AddressRadioGroup> createState() => _AddressRadioGroupState();
}

class _AddressRadioGroupState extends State<AddressRadioGroup> {


  int? id;
  AddressMode? selected;

  String? address;
  String? city;
  String? pin;

  @override
  void initState() {
    super.initState();
    address = Get
        .find<AccountLogic>()
        .userModel
        ?.address ?? "";
    city = Get
        .find<AccountLogic>()
        .userModel
        ?.city ?? "";
    pin = Get
        .find<AccountLogic>()
        .userModel
        ?.pincode ?? "";
    if ((address?.isNotEmpty ?? false)) {
      selected = AddressMode.address;
      id = 1;
    } else {
      selected = AddressMode.alterNative;
      id = 2;
    }
  }

  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController address2CityController = TextEditingController();
  final TextEditingController address2PinController = TextEditingController();

  bool isEnableEditBox = false;

  bool saveAsDefault = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        if(address?.isNotEmpty ?? false)
          InkWell(
            onTap: () {
              selected = AddressMode.address;
              id = 1;
              if (widget.callback != null) {
                widget.callback!(AddressModel(
                    address: address,
                    city: city,
                    pin: pin
                ));
              }
              setState(() {});
              Get.find<CheckoutLogic>().clearPincodeError();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    selected = AddressMode.address;
                    id = 1;
                    if (widget.callback != null) {
                      widget.callback!(AddressModel(
                          address: address,
                          city: city,
                          pin: pin
                      ));
                    }
                    setState(() {});
                    Get.find<CheckoutLogic>().clearPincodeError();
                  },
                ),
                Text(
                  'Default Address'.tr,
                  style: TextStyle(
                      color: AppColors.blackColor(),
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),

        if((address?.isNotEmpty ?? false) && selected == AddressMode.address)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme
                            .of(context)
                            .primaryColor, width: 0.2)
                    ),
                    child: Icon(Icons.location_on, color: Theme
                        .of(context)
                        .primaryColor, size: 15,)),
                const SizedBox(width: 12,),
                Flexible(child: Text("${address!} ${pin ?? ""}")),
              ],
            ),
          ),

        SizedBox(height: 10,),

        InkWell(
          onTap: () {
            selected = AddressMode.alterNative;
            id = 2;
            if (widget.callback != null) {
              if (address2Controller.text.isNotEmpty &&
                  address2CityController.text.isNotEmpty &&
                  address2PinController.text.isNotEmpty) {
                widget.callback!(AddressModel(
                    address: address2Controller.text,
                    pin: address2PinController.text,
                    city: address2CityController.text
                ));
              } else {
                widget.callback!(AddressModel());
              }
            }
            setState(() {});
            Get.find<CheckoutLogic>().clearPincodeError();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: 2,
                groupValue: id,
                onChanged: (val) {
                  selected = AddressMode.alterNative;
                  id = 2;
                  if (widget.callback != null &&
                      address2Controller.text.isNotEmpty &&
                      address2CityController.text.isNotEmpty &&
                      address2PinController.text.isNotEmpty) {
                    widget.callback!(AddressModel(
                        address: address2Controller.text,
                        pin: address2PinController.text,
                        city: address2CityController.text,
                        saveAsDefault: saveAsDefault
                    ));
                  } else {
                    widget.callback!(AddressModel());
                  }
                  setState(() {});
                  Get.find<CheckoutLogic>().clearPincodeError();
                },
              ),
              Text(
                'Another Place'.tr,
                style: TextStyle(
                    color: AppColors.blackColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),


        if(selected == AddressMode.alterNative)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CommonInputField(
                  hintText: 'Delivery Address'.tr,
                  labelText: "Delivery Address".tr,
                  onTextChanged: (str) {
                    if (widget.callback != null) {
                      widget.callback!(AddressModel(
                          address: str.isEmpty ? null : str,
                          pin: address2PinController.text.isEmpty
                              ? null
                              : address2PinController.text,
                          city: address2CityController.text.isEmpty
                              ? null
                              : address2CityController.text
                      ));
                    }
                  },
                  textController: address2Controller,
                  keyboardType: TextInputType.streetAddress,
                  suffixIcon: const Icon(Icons.location_on),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CommonInputField(
                    hintText: 'City'.tr,
                    labelText: "City".tr,
                    onTextChanged: (str) {
                      if (widget.callback != null) {
                        widget.callback!(AddressModel(
                          address: address2Controller.text.isEmpty
                              ? null
                              : address2Controller.text,
                          pin: address2PinController.text.isEmpty
                              ? null
                              : address2PinController.text,
                          city: str.isEmpty ? null : str,
                        ));
                      }
                    },
                    textController: address2CityController,
                    keyboardType: TextInputType.streetAddress,
                    suffixIcon: const Icon(Icons.location_city),
                  ),
                ),

                GetBuilder<CheckoutLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CommonInputField(
                        hintText: 'Pincode'.tr,
                        labelText: "Pincode".tr,
                        onTextChanged: (str) {
                          if (widget.callback != null) {
                            print("CALLBACK_$str");
                            widget.callback!(AddressModel(
                              address: address2Controller.text.isEmpty
                                  ? null
                                  : address2Controller.text,
                              pin: str.isEmpty ? null : str,
                              city: address2CityController.text.isEmpty
                                  ? null
                                  : str,
                            ));
                          }

                          if (str.length == 6) {
                            logic.addressModel ??= AddressModel();
                            logic.addressModel?.pin = str;
                            logic.serviceAvailable();
                          }else{
                            logic.clearPincodeError();
                          }
                        },
                        textController: address2PinController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        suffixIcon: const Icon(Icons.pin),
                      ),
                    );
                  },
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Checkbox(
                        value: saveAsDefault,
                        onChanged: (bool? value) {
                          saveAsDefault = value??false;
                          if (widget.callback != null) {
                            widget.callback!(AddressModel(
                                address: address2Controller.text.isEmpty
                                    ? null
                                    : address2Controller.text,
                                pin: address2PinController.text.isEmpty
                                    ? null
                                    : address2PinController.text,
                                city: address2CityController.text.isEmpty
                                    ? null
                                    : address2CityController.text,
                                saveAsDefault: saveAsDefault
                            ));
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Text("Save this address as a default address"),
                  ],
                ),

              ],
            ),
          ),

      ],
    );
  }
}
