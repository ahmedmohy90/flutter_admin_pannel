class TRoutes {
  static const login = '/login';
  static const forgetPassword = '/forgetPassword';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editsCategories = '/editCategory';

  static const brands = '/brands';
  static const createBrands = '/createBrands';
  static const editBrands = '/editBrands';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static const customers = '/customers';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';


  static const coupons = '/coupons';
  static const settings = '/settings';
  static const profile = '/profile';

  static const sidebarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders
  ];
}
