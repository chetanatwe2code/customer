import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/utils/assets.dart';

import '../../theme/app_colors.dart';
import '../../controller/account_controller.dart';
import '../login/view.dart';
import '../widget/common_image.dart';
import '../widget/common_material_button.dart';
import '../widget/input_field/common_input_field.dart';
import '../widget/show_animated_dialog.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  AccountLogic controller = Get.find<AccountLogic>();
  File? file;

  @override
  void initState() {
    super.initState();
    controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery
        .of(context)
        .size;
    bool isSmall = !isLargeScreen(media);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile".tr),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              (isSmall ? 10 : 20).verticalSpace,

              GetBuilder<AccountLogic>(builder: (logic) {
                return Container(
                  padding: REdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  margin: REdgeInsets.only(bottom: 27),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: getGalleryOrCamara,
                        child: Stack(
                          children: [
                            Container(
                              width: 70.r,
                              height: 70.r,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.r,
                                  color: AppColors.blackColor().withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(70.r),
                              ),
                              child:
                                 file != null ?
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                                      color: Theme.of(context).selectedRowColor,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.file(File(file?.path ?? ""),
                                        height: 70.0,
                                        width: 70.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ) :
                              CommonImage(
                                imageUrl: controller.userModel?.image??"",
                                assetPlaceholder: appUser,
                                width: 70,
                                height: 70,
                                radius: 70,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 5,
                                child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    decoration:  BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor(),
                                          AppColors.whiteColor(),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryColor(),
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Icon(Icons.photo , size: 15 , color: Colors.white54,)
                                )
                            )
                          ],
                        ),
                      ),
                      15.horizontalSpace,
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${logic.userModel?.firstName ?? ""} ${logic
                                .userModel?.lastName ?? ""}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: isSmall ? 16.sp : 15.sp,
                                letterSpacing: -1,
                                color: AppColors.textColor(),
                              ),
                            ),
                            3.verticalSpace,
                            Text(logic.userModel?.email ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: isSmall ? 13.sp : 12.sp,
                                letterSpacing: -1,
                                color: AppColors.textColor(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),

              20.verticalSpace,

              CommonInputField(
                hintText: 'Enter first name'.tr,
                labelText: "First Name".tr,
                maxLength: 15,
                textController: controller.firstNameController,
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person),
              ),

              20.verticalSpace,


              CommonInputField(
                hintText: 'Enter last name'.tr,
                labelText: "Last Name".tr,
                maxLength: 15,
                textController: controller.lastNameController,
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(Icons.person),
              ),

              20.verticalSpace,

              CommonInputField(
                hintText: 'Enter phone number'.tr,
                labelText: "Number".tr,
                maxLength: 10,
                textController: controller.numberController,
                keyboardType: TextInputType.phone,
                suffixIcon: const Icon(Icons.phone),
              ),

              40.verticalSpace,

              Text("Address Details".tr,
                style: TextStyle(
                    color: AppColors.textColor(),
                    fontSize: isSmall ? 16.sp : 15.sp,
                    fontWeight: FontWeight.bold
                ),),



              20.verticalSpace,

              CommonInputField(
                hintText: 'Address'.tr,
                labelText: "Address".tr,
                textController: controller.addressController,
                keyboardType: TextInputType.streetAddress,
                suffixIcon: const Icon(Icons.location_on),
              ),
              //
              // 20.verticalSpace,
              //
              // CommonInputField(
              //   hintText: 'Address line 2',
              //   labelText: "Address Line 2",
              //   textController: controller.address2Controller,
              //   keyboardType: TextInputType.streetAddress,
              //   suffixIcon: const Icon(Icons.location_on),
              // ),

              20.verticalSpace,

              CommonInputField(
                hintText: 'City Name'.tr,
                labelText: "City".tr,
                textController: controller.cityController,
                keyboardType: TextInputType.streetAddress,
                suffixIcon: const Icon(Icons.location_city),
              ),

              20.verticalSpace,

              CommonInputField(
                hintText: 'Pin-Code'.tr,
                labelText: "Pin-Code".tr,
                maxLength: 6,
                textController: controller.pinCodeController,
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.pin),
              ),

              20.verticalSpace,

              Obx(() {
                return CommonMaterialButton(text: "Update Profile".tr,
                    color: AppColors.primaryColor(),
                    borderRadius: 5,
                    height: 50.h,
                    fontSize: 12.sp,
                    fontColor: AppColors.whiteColor(),
                    isLoading: controller.updateProcess.value,
                    onTap: () {
                      controller.updateUser(file);
                    });
              }),

              10.verticalSpace,

            ],
          ),
        ),
      ),
    );
  }

  Future<void> getGalleryOrCamara() async {
    return showAnimatedDialog(context , Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [

            Positioned(
              left: 0,
              top: 5,
              child: Row(
                children: [
                  Icon(Icons.photo , color: Theme.of(context).highlightColor, size: 24,),
                  const SizedBox(width: 10,),
                  Text("Choose Option".tr,),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Divider(height: 1,color: Theme.of(context).primaryColor,),
                    ListTile(
                      onTap: (){
                        pickGalleryPic().then((value) => {
                          Navigator.pop(context)
                        });
                      },
                      title: Text("Gallery".tr),
                      leading: Icon(Icons.perm_media,color: Theme.of(context).highlightColor,),
                    ),

                    Divider(height: 1,color: Theme.of(context).primaryColor,),
                    ListTile(
                      onTap: (){
                        pickCameraPic().then((value) => {
                          Navigator.pop(context),
                        });
                      },
                      title: Text("Camera".tr),
                      leading: Icon(Icons.camera,color: Theme.of(context).highlightColor,),
                    ),
                  ],
                ),
              ),),

          ],
        ),
      ),
    ) , dismissible: true);
  }


  Future<void> pickGalleryPic() async{
    try{
      await FilePicker.platform.pickFiles(withReadStream: true , type: FileType.image).then((value) =>{
        if(value != null){
          file = File(value.files.single.path!),
          if(mounted){
            setState(() {})
          }
        },
      });
    }catch(e){
      //
    }
  }

  Future<void> pickCameraPic() async{
    try{
      final ImagePicker picker = ImagePicker();
      final mImage = await picker.pickImage(source: ImageSource.camera);
      if(mImage == null) return;
      await getFile(File(mImage.path)).then((value) => {
        file = value,
        if(mounted){
          setState(() {}),
        },
      });
    } on PlatformException catch (e){
      //
    }
  }
}

Future<File> getFile(File file) async{
  return file;
}
