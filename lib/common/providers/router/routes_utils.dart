enum AppPage {
  splash,
  parkHome,
  error,
  landing,
  boot,
  mngDog,
  about,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.parkHome:
        return "/park";
      case AppPage.error:
        return "/error";
      case AppPage.landing:
        return "/landing";
      case AppPage.boot:
        return "/boot";
      case AppPage.mngDog:
        return "/MngDog";
      case AppPage.about:
        return "/about";
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
      case AppPage.mngDog:
        return "MNG_DOG";
      case AppPage.about:
        return "ABOUT";
      default:
        return "PARK";
    }
  }
}
