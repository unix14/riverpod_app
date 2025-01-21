
enum AppPages {
  login,
  logout,
  products,
  pagex,
  cart,
  business,
  orders,

  cartNext,
  businessNext,
  ordersNext,
}

const String login = "/";
const String logout = "/logout";
const String products = "/products";
const String pagex = "/products/pagex";
const String cart = "/cart";
const String business = "/business";
const String orders = "/orders";

const String cartNext = "/cartNext";
const String businessNext = "/businessNext";
const String ordersNext = "/ordersNext";


extension AppPageExtension on AppPages {
  String get routePath {
    switch (this) {
      case AppPages.login:
        return login;
      case AppPages.logout:
        return logout;
      case AppPages.products:
        return products;
      case AppPages.pagex:
        return pagex;
      case AppPages.cart:
        return cart;
      case AppPages.business:
        return business;
      case AppPages.orders:
        return orders;


      case AppPages.cartNext:
        return cartNext;
      case AppPages.businessNext:
        return businessNext;
      case AppPages.ordersNext:
        return ordersNext;
    }
  }

  /// use this method to call GoRouter with the relevant params.
  String withParams(List<String> params) {
    final paramsPath = params.reduce((value, element) => '/$value/$element');

    switch (this) {
      case AppPages.login:
        return "/login$paramsPath";
      case AppPages.logout:
        return "/logout$paramsPath";
      case AppPages.products:
        return "/products$paramsPath";
      case AppPages.pagex:
        return "/products/pagex$paramsPath";
      case AppPages.cart:
        return "/cart$paramsPath";
      case AppPages.business:
        return "/business$paramsPath";
      case AppPages.orders:
        return "/orders$paramsPath";


      case AppPages.cartNext:
        return "/next$paramsPath";
      case AppPages.businessNext:
        return "/business/next$paramsPath";
      case AppPages.ordersNext:
        return "/orders/next$paramsPath";
    }
  }

// for named routes
  String get routeName {
    switch (this) {
      case AppPages.login:
        return "LOGIN";
      case AppPages.logout:
        return "LOGOUT";
      case AppPages.products:
        return "PRODUCTS";
      case AppPages.pagex:
        return "PAGEX";
      case AppPages.cart:
        return "CART";
      case AppPages.business:
        return "BUSINESS";
      case AppPages.orders:
        return "ORDERS";

      case AppPages.cartNext:
        return "CART_NEXT";
      case AppPages.businessNext:
        return "BUSINESS_NEXT";
      case AppPages.ordersNext:
        return "ORDERS_NEXT";
    }
  }

// for page titles to use on appbar
  String get routePageTitle {
    switch (this) {
      case AppPages.login:
        return "Login";
      case AppPages.logout:
        return "Logout";
      case AppPages.products:
        return "Products";
      case AppPages.pagex:
        return "PageX";
      case AppPages.cart:
        return "Cart";
      case AppPages.business:
        return "Business";
      case AppPages.orders:
        return "Orders";


      case AppPages.cartNext:
        return "Cart Next";
      case AppPages.businessNext:
        return "Business Next";
      case AppPages.ordersNext:
        return "Orders Next";
    }
  }
}
