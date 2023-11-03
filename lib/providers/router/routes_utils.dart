enum AppPage {
  splash,
  login,
  register,
  park,
  error,
  landing,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.park:
        return "/";
      case AppPage.login:
        return "/login";
      case AppPage.register:
        return "/register";
      case AppPage.splash:
        return "/splash";
      case AppPage.error:
        return "/error";
      case AppPage.landing:
        return "/landing";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.park:
        return "PARK";
      case AppPage.login:
        return "LOGIN";
      case AppPage.register:
        return "REGISTER";
      case AppPage.splash:
        return "SPLASH";
      case AppPage.error:
        return "ERROR";
      case AppPage.landing:
        return "LANDING";
      default:
        return "PARK";
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.park:
        return "My App";
      case AppPage.login:
        return "My App Log In";
      case AppPage.register:
        return "My App Register";
      case AppPage.splash:
        return "My App Splash";
      case AppPage.error:
        return "My App Error";
      case AppPage.landing:
        return "Welcome to My App";
      default:
        return "My App";
    }
  }
}
