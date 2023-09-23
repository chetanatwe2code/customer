
import 'package:get/get.dart';
import 'package:indiakinursery/view/add_review/binding.dart';
import 'package:indiakinursery/view/my_complain/binding.dart';
import 'package:indiakinursery/view/support/binding.dart';
import '../view/account/view.dart';
import '../view/add_review/view.dart';
import '../view/base_view.dart';
import '../view/cart/view.dart';
import '../view/category/binding.dart';
import '../view/category/view.dart';
import '../view/change_password/binding.dart';
import '../view/change_password/view.dart';
import '../view/checkout/view.dart';
import '../view/edit_profile/view.dart';
import '../view/forgot_password/binding.dart';
import '../view/forgot_password/view.dart';
import '../view/login/binding.dart';
import '../view/login/view.dart';
import '../view/my_complain/view.dart';
import '../view/notification/binding.dart';
import '../view/notification/view.dart';
import '../view/order/binding.dart';
import '../view/order/view.dart';
import '../view/order_list/binding.dart';
import '../view/order_list/view.dart';
import '../view/product/binding.dart';
import '../view/product/view.dart';
import '../view/product_detail/binding.dart';
import '../view/product_detail/view.dart';
import '../view/search/view.dart';
import '../view/sign_up/binding.dart';
import '../view/sign_up/view.dart';
import '../view/splash/binding.dart';
import '../view/splash/view.dart';
import '../view/support/view.dart';
import '../view/transition/binding.dart';
import '../view/transition/view.dart';
import '../view/verification/binding.dart';
import '../view/verification/view.dart';

/// application routes name
const String rsDefaultPage = "/";
const String rsLoginPage = "/loginScreen";
const String rsSignUpPage = "/signUpScreen";
const String rsVerificationPage = "/verificationScreen";
const String rsForgotPasswordPage = "/forgotPasswordScreen";
const String rsChangePasswordPage = "/changePasswordScreen";
const String rsEditProfilePage = "/editProfileScreen";
const String rsBasePage = "/baseScreen";
const String rsProductPage = "/productScreen";
const String rsProductDetailPage = "/productDetailScreen";
const String rsCheckoutPage = "/checkoutScreen";
const String rsOrderHistoryPage = "/orderHistoryScreen";
const String rsNotificationPage = "/notificationScreen";
const String rsAccountPage = "/profileScreen";
const String rsOrderPage = "/rsOrderScreen";
const String rsSupportPage = "/rsSupportScreen";
const String rsTransitionPage = "/TransitionScreen";
const String rsAddReviewPage = "/AddReviewScreen";
const String rsMyComplainPage = "/MyComplainScreen";

const String rsCategoryPage = "/CategoryScreen";
const String rsSearchPage = "/searchScreen";
//const String rsCartPage = "/cartScreen";

class Routes{
  static final routes = [

    // how can add custom Transition
    GetPage(name: rsBasePage, page: () => const BasePage(),transition: Transition.leftToRight),
    //GetPage(name: rsCartPage, page: () => const CartPage()),
    GetPage(name: rsAccountPage, page: () => const AccountPage()),
    GetPage(name: rsSearchPage, page: () => const SearchPage()),
    GetPage(name: rsCheckoutPage, page: () => const CheckoutPage()),

    GetPage(name: rsCategoryPage, page: () => const CategoryPage(),binding: CategoryBinding()),

    GetPage(name: rsDefaultPage, page: () => const SplashPage(),binding: SplashBinding()),
    GetPage(name: rsLoginPage, page: () => const LoginPage(),binding: LoginBinding()),
    GetPage(name: rsSignUpPage, page: () => const SignUpPage(),binding: SignUpBinding()),
    GetPage(name: rsForgotPasswordPage, page: () => const ForgotPasswordPage(),binding: ForgotPasswordBinding()),
    GetPage(name: rsVerificationPage, page: () => const VerificationPage(),binding: VerificationBinding()),
    GetPage(name: rsChangePasswordPage, page: () => const ChangePasswordPage(),binding: ChangePasswordBinding()),
    GetPage(name: rsEditProfilePage, page: () => const EditProfilePage()),
    GetPage(name: rsProductPage, page: () => const ProductPage(),binding: ProductBinding()),
    GetPage(name: rsProductDetailPage, page: () => const ProductDetailPage(),binding: ProductDetailBinding()),
    GetPage(name: rsOrderHistoryPage, page: () => const OrderHistoryPage(),binding: OrderHistoryBinding()),
    GetPage(name: rsOrderPage, page: () => const OrderPage(),binding: OrderBinding()),
    GetPage(name: rsNotificationPage, page: () => const NotificationPage(),binding: NotificationBinding()),
    GetPage(name: rsSupportPage, page: () => const SupportPage(),binding: SupportBinding()),
    GetPage(name: rsTransitionPage, page: () => const TransitionPage(),binding: TransitionBinding()),
    GetPage(name: rsAddReviewPage, page: () => const AddReviewPage(),binding: AddReviewBinding()),
    GetPage(name: rsMyComplainPage, page: () => const MyComplainPage(),binding: MyComplainBinding()),
  ];
}