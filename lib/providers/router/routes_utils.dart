enum AppPage {
  splash,
  login,
  register,
  park,
  error,
  landing,
  boot,
  addDog,
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
      case AppPage.boot:
        return "/boot";
      case AppPage.addDog:
        return "/addDog";
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
      case AppPage.boot:
        return "BOOT";
      case AppPage.addDog:
        return "ADD_DOG";
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
      case AppPage.boot:
        return "My App Boot";
      case AppPage.addDog:
        return "My App Add Dog";
      default:
        return "My App";
    }
  }
}
