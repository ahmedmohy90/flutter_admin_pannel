import 'package:admin_pannel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:admin_pannel/features/authentication/screens/login/login_screens.dart';
import 'package:admin_pannel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:admin_pannel/features/media/screens.media/media_screen.dart';
import 'package:admin_pannel/features/shop/screens/banners/all_banners/banners_screen.dart';
import 'package:admin_pannel/features/shop/screens/banners/create_banner/create_banner_screen.dart';
import 'package:admin_pannel/features/shop/screens/banners/edit_brand/edit_banner_screen.dart';
import 'package:admin_pannel/features/shop/screens/brand/all_brands/brands_screen.dart';
import 'package:admin_pannel/features/shop/screens/brand/create_brand/create_banner_screen.dart';
import 'package:admin_pannel/features/shop/screens/customers/all_customers/customers_screen.dart';
import 'package:admin_pannel/features/shop/screens/customers/customer_details/customer_details_screen.dart';
import 'package:admin_pannel/features/shop/screens/order/all_orders/orders.dart';
import 'package:admin_pannel/features/shop/screens/order/order_details/order_details.dart';
import 'package:admin_pannel/features/shop/screens/products/all_products/products_screen.dart';
import 'package:admin_pannel/features/shop/screens/products/edit_product/edit_product_screen.dart';
import 'package:admin_pannel/routes/routes.dart';
import 'package:get/get.dart';

import '../features/personalization/screens/profile/profile_screen.dart';
import '../features/personalization/screens/settings/settings_screen.dart';
import '../features/shop/screens/brand/edit_brand/edit_brand_screen.dart';
import '../features/shop/screens/category/all_categories/categories_screen.dart';
import '../features/shop/screens/category/create_category/create_category_screen.dart';
import '../features/shop/screens/category/edit_category/edit_category_screen.dart';
import '../features/shop/screens/dashboard/dashboard_screen.dart';
import '../features/shop/screens/products/create_product/create_product_screen.dart';
import 'routes_middleware.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: TRoutes.login,
      page: () => const LoginScreens(),
    ),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: TRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [TMiddleware()]),

    GetPage(
        name: TRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [TMiddleware()]),

    // Categories
    GetPage(
      name: TRoutes.categories,
      page: () => const CategoriesScreen(),
      middlewares: [TMiddleware()],
    ),

    // create categories
    GetPage(
      name: TRoutes.createCategory,
      page: () => const CreateCategoryScreen(),
      middlewares: [TMiddleware()],
    ),
    // edit categories
    GetPage(
      name: TRoutes.editsCategories,
      page: () => const EditCategoryScreen(),
      middlewares: [TMiddleware()],
    ),

    // brands
    GetPage(
      name: TRoutes.brands,
      page: () => const BrandsScreen(),
      middlewares: [TMiddleware()],
    ),

    // create brands
    GetPage(
      name: TRoutes.createBrands,
      page: () => const CreateBrandScreen(),
      middlewares: [TMiddleware()],
    ),
    // edit brands
    GetPage(
      name: TRoutes.editBrands,
      page: () => const EditBrandScreen(),
      middlewares: [TMiddleware()],
    ),

    // Banners
    GetPage(
      name: TRoutes.banners,
      page: () => const BannersScreen(),
      middlewares: [TMiddleware()],
    ),

    // create Banners
    GetPage(
      name: TRoutes.createBanner,
      page: () => const CreateBannerScreen(),
      middlewares: [TMiddleware()],
    ),

    GetPage(
      name: TRoutes.editBanner,
      page: () => const EditBannerScreen(),
      middlewares: [TMiddleware()],
    ),

    GetPage(
      name: TRoutes.products,
      page: () => const ProductsScreen(),
      middlewares: [TMiddleware()],
    ),

    // create Prodcuts
    GetPage(
      name: TRoutes.createProduct,
      page: () => const CreateProductScreen(),
      middlewares: [TMiddleware()],
    ),
// edit Prodcuts
    GetPage(
      name: TRoutes.editProduct,
      page: () => const EditProductScreen(),
      middlewares: [TMiddleware()],
    ),

// Customers
    GetPage(
      name: TRoutes.customers,
      page: () => const CustomersScreen(),
      middlewares: [TMiddleware()],
    ),

    // create Prodcuts
    GetPage(
      name: TRoutes.customerDetails,
      page: () => const CustomerDetailsScreen(),
      middlewares: [TMiddleware()],
    ),

    // Customers
    GetPage(
      name: TRoutes.orders,
      page: () => const OrdersScreen(),
      middlewares: [TMiddleware()],
    ),

    // create Prodcuts
    GetPage(
      name: TRoutes.orderDetails,
      page: () => const OrderDetailsScreen(),
      middlewares: [TMiddleware()],
    ),

    GetPage(
      name: TRoutes.settings,
      page: () => const SettingsScreen(),
      middlewares: [TMiddleware()],
    ),
    GetPage(
      name: TRoutes.profile,
      page: () => const ProfileScreen(),
      middlewares: [TMiddleware()],
    ),
  ];
}
