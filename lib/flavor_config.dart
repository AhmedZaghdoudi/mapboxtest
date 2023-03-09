class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }
}

enum Flavor {
  outdoor,
  historic,
}

class FlavorValues {
  FlavorValues({required this.urlTemplate});
  final String? urlTemplate;
}

class FlavorConfig {
  final Flavor flavor;
  final String urlTemplate;
  static late FlavorConfig _instance;
  factory FlavorConfig({
    required Flavor flavor,
    required String urlTemplate,
  }) {
    _instance = FlavorConfig._internal(flavor, urlTemplate);
    return _instance;
  }
  FlavorConfig._internal(
    this.flavor,
    this.urlTemplate,
  );
  //, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isOutdoor() => _instance.flavor == Flavor.outdoor;
  static bool isHistoric() => _instance.flavor == Flavor.historic;
}
