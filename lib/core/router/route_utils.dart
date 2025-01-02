
enum AppPages {
  login,
  logout,
  products,
  pagex,
}

const String login = "/";
const String logout = "/logout";
const String products = "/products";
const String pagex = "/products/pagex";


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

    }
  }
}
