enum AppPage {
  splash,
  login,
  register,
  park,
  error,
  landing,
  boot,
  addDog,
  profile,
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
      default:
        return "My App";
    }
  }
}
