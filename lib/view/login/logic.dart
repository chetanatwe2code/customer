import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/routes.dart';
import '../../repository/login_repo.dart';
import '../../utils/email_validator.dart';
import '../widget/toast.dart';

enum LoginType { google,facebook }

class LoginLogic extends GetxController {
  final LoginRepo loginRepo;
  LoginLogic({required this.loginRepo});

  var obscureText = true.obs;
  void toggle() {
    obscureText.value = !obscureText.value;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    emailController.text = argumentData?['email']??"";
    super.onInit();
  }

  Future<void> signInWithGoogle() async{
    // instance
    FirebaseAuth _auth = FirebaseAuth.instance;


    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.isSignedIn().then((value) => {
      if(value){
        _googleSignIn.disconnect()
      }
    });

    try{
      // sign In with google
      final GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      _googleSignIn.signInSilently();
      final GoogleSignInAuthentication authentication = await signInAccount!.authentication;

      // verify authentication credential
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken:  authentication.idToken,
          accessToken: authentication.accessToken
      );


      // signIn with FirebaseAuth
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      //print(AppString.appPrintTag + user.toString());
      print("providerData ${user?.providerData}");
      //print(AppString.appPrintTag + "${user.providerData[0].displayName}");

      // check user verify
      assert(!user!.isAnonymous);
      final User? currentUser = _auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      assert(user!.providerData[0].email != null);
      goToSocialLogin(
        uid: user!.uid ,
        email: user.providerData[0].email! ,
        loginType: LoginType.google,
        name: user.providerData[0].displayName??"",
        userPhone: user.providerData[0].phoneNumber ?? "",
        photoURL: user.providerData[0].photoURL??"",
      );
    }
    catch (e){
      print("catch_by $e");
    }
  }

  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email']
    );

    try{
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        final userData = await FacebookAuth.instance.getUserData();

        assert(userCredential.user!.uid.isNotEmpty);
        assert(userData.isNotEmpty);
        String email =  userData["email"];
        String name =  userData["name"];
        print("catch_by :: $userData");
        goToSocialLogin(
            uid: userCredential.user!.uid ,
            name: name ,
            email: email ,
            userPhone: "",
            loginType: LoginType.facebook);
      }
    }catch (e){
      print("catch_by $e");
    }
  }

  goToSocialLogin({
    required String email ,
    String? name ,
    String? photoURL ,
    required String uid ,
    String? userPhone ,
    required LoginType loginType
  }){
    loginProcess.value = true;
    loginRepo.socialLogin({
      "email": email,
      "uid": uid,
      "phone_no": userPhone,
      "first_name": name,
      "image": photoURL,
    }).then((value) => {
      print("RES_____${value.body}"),
      loginProcess.value = false,
      if(int.tryParse(value.body['res_code']) == 001){
        loginRepo.saveLoginData(value.body['token']),
        Get.offAllNamed(rsBasePage,arguments: {"from_login" : 1}),
      }else if(int.tryParse(value.body['res_code']) == 003){
        Toast.show(toastMessage: "Your login credentials do not match",isError: true),
      }
      else{
          Toast.show(toastMessage: "something when wrong",isError: true),
        },
      loginProcess.value = false,
    },onError: (e){
      print("RES_____${e}");
    }).catchError((e){
      loginProcess.value = false;
      Toast.show(toastMessage: "something when wrong",isError: true);// digit
    });
  }

  var loginProcess = false.obs;
  login({ required BuildContext context }) async{
    if(!kReleaseMode){
      //emailController.text = "sagar.we2code@gmail.com";
      emailController.text = "chetan.barod.we2code@gmail.com";
      //passwordController.text = "12345";
      passwordController.text = "12345678";
    }
    if(!validateLoginData()) return; // repository repository repository

    loginProcess.value = true;
    loginRepo.login({
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) => {
      loginProcess.value = false,
      if(value.body['status'] == true){
        loginRepo.saveLoginData(value.body['token']),
        Get.offAllNamed(rsBasePage,arguments: {"from_login" : 1}),
      }else{
        Toast.show(toastMessage: value.body['response'] ?? value.body['message'] ?? "Internal server error",isError: true),
      },
      loginProcess.value = false,
    },onError: (e){
      print("RES_____${e}");
    }).catchError((e){
      loginProcess.value = false;
      Toast.show(toastMessage: "something when wrong",isError: true);// digit
    });
  }


  bool validateLoginData() {
    if (emailController.text.isNotEmpty) {
      final email = emailController.text.trim();
      if (email.length == 10 && int.tryParse(email) != null) {
        // If the email is a 10-digit number
        if (passwordController.text.isNotEmpty) {
          return true;
        } else {
          Toast.show(toastMessage: "Enter Password".tr, isError: true);
        }
      } else if (EmailValidator.validate(email)) {
        // If the email is a valid email address
        if (passwordController.text.isNotEmpty) {
          return true;
        } else {
          Toast.show(toastMessage: "Enter Password".tr, isError: true);
        }
      } else {
        Toast.show(toastMessage: "Enter a valid email or 10-digit phone number", isError: true);
      }
    } else {
      Toast.show(toastMessage: "Enter email", isError: true);
    }
    return false;
  }





// validateLoginData(){
  //   if(emailController.text.isNotEmpty)
  //     if(EmailValidator.validate(emailController.text)) // how can valid it is valid if have 10 digit number ar email in emailController
  //       if(passwordController.text.isNotEmpty)
  //         return true;
  //       else
  //         Toast.show(toastMessage: "Enter password",isError: true);
  //     else
  //       Toast.show(toastMessage: "Enter Valid Email",isError: true);
  //     else
  //     Toast.show(toastMessage: "Enter Email",isError: true);
  //   return false;
  //
  // }

}
