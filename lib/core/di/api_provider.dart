class ApiProvider{

  static const String baseLocal = 'http://192.168.29.108:9999/';
  static const String baseUrl = 'http://www.indiakinursery.com:9999/';
  static const String baseUrl2 = 'https://nursery-verient-live.onrender.com/';

  /// Auth APIs
  static const String userLogin = 'user_login';
  static const String socialLogin = 'social_login';
  static const String userRegister = 'user_signup';
  static const String userVerify = 'user_otp_verify';

  static const String userForgotPassword = 'user_forgate_password';

  ///static const String changePassword = 'change_user_password';
  static const String changePassword = 'user_forgate_password_update';
  static const String userDetails = 'user_details';
  static const String userUpdate = 'update_user';

  /// Banner APIs
  static const String getBanner = 'banner';

  /// Category Brand APIs
  static const String getCategoryAndBrand = 'filter_list';
  static const String getCategory = 'category_list';

   /// Product APIs
   static const String getProduct = 'search';
   static const String getTrendingProduct = 'trending_products';
   static const String getProductReview = 'review_list';
   static const String addProductReview = 'review_rating';

   /// support
  static const String addComplain = 'add_complain';
  static const String getComplain = 'complain_search';

   /// Notification
   static const String getNotification = 'notification';
   static const String setNotificationToken = 'set_notification_token';
   static const String getCartNotificationCount = 'cart_and_notification_count';

  /// Cart APIs
  static const String getCart = 'cart_list_1';
  static const String addToCart = 'add_to_cart';
  static const String updateCart = 'cart_update';
  static const String deleteCart = 'cart_delete';

  /// Order APIs
  static const String orderPlace = 'add_order_1';
  static const String getOrder = 'order_search';
  static const String orderDetails = 'order_details';
  static const String checkAvailable = 'check_vendor_service_avaibility';
  static const String cancelOrder = 'cancel_order';

  /// Session key
  static const String preferencesToken = 'USER_TOKEN';
  static const String preferencesIsLogin = 'USER_LOGGED_IN';

}