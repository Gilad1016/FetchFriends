enum AppPage {
  splash,
  parkHome,
  error,
  landing,
  boot,
  addDog,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.parkHome:
        return "/";
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
      case AppPage.parkHome:
        return "PARK";
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
      case AppPage.parkHome:
        return "My App";
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
