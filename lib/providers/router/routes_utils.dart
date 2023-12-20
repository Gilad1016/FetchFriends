enum AppPage {
  splash,
  login,
  register,
  parkHome,
  error,
  landing,
  boot,
  addDog,
  profile,
  requestPermission,
  addPreferredPark,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.parkHome:
        return "/";
      case AppPage.login:
        return "/login";
      case AppPage.register:
        return "/register";
      case AppPage.error:
        return "/error";
      case AppPage.landing:
        return "/landing";
      case AppPage.boot:
        return "/boot";
      case AppPage.addDog:
        return "/addDog";
      case AppPage.profile:
        return "/profile";
      case AppPage.requestPermission:
        return "/requestPermission";
      case AppPage.addPreferredPark:
        return "/addPreferredPark";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.parkHome:
        return "PARK";
      case AppPage.login:
        return "LOGIN";
      case AppPage.register:
        return "REGISTER";
      case AppPage.error:
        return "ERROR";
      case AppPage.landing:
        return "LANDING";
      case AppPage.boot:
        return "BOOT";
      case AppPage.addDog:
        return "ADD_DOG";
      case AppPage.profile:
        return "PROFILE";
      case AppPage.requestPermission:
        return "REQUEST_PERMISSION";
      case AppPage.addPreferredPark:
        return "ADD_PREFERRED_PARK";
      default:
        return "PARK";
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.parkHome:
        return "My App";
      case AppPage.login:
        return "My App Log In";
      case AppPage.register:
        return "My App Register";
      case AppPage.error:
        return "My App Error";
      case AppPage.landing:
        return "Welcome to My App";
      case AppPage.boot:
        return "My App Boot";
      case AppPage.addDog:
        return "My App Add Dog";
      case AppPage.profile:
        return "My App Profile";
      case AppPage.requestPermission:
        return "My App Request Permission";
      default:
        return "My App";
    }
  }
}
