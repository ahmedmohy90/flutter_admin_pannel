import 'package:cloud_firestore/cloud_firestore.dart';

class AppScreens {
  static const home = '/';
  static const store = '/store';
  static const favorites = '/favorites';
  static const settings = '/settings';
  static const subCategories = '/subCategories';
  static const search = '/search';
  static const productReviews = '/product-reviews';
  static const productDeyails = '/product-deyails';

  static const order = '/order';
  static const checkout = '/checkout';
  static const cart = '/cart';
  static const brand = '/brand';
  static const allProducts = '/all-products';
  static const userProfile = '/user-profile';
  static const userAddress = '/user-address';

  static const signUp = '/signup';
  static const signupSuccess = '/signup-success';
  static const verifyEmail = '/verify-email';
  static const signIn = '/sign-in';
  static const resetPassword = '/reset-password';
  static const forgetPassword = '/forget-password';
  static const onBoarding = '/on-boarding';

  static List<String> allAppScreenItems = [
    home,
    store,
    favorites,
    settings,
    subCategories,
    search,
    productReviews,
    productDeyails,
    order,
    checkout,
    cart,
    brand,
    allProducts,
    userProfile,
    userAddress,
    signUp,
    signupSuccess,
    verifyEmail,
    signIn,
    resetPassword,
    forgetPassword,
    onBoarding
  ];
}
