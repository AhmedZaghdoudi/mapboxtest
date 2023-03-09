import 'flavor_config.dart';
import 'main_comman.dart';

void main() {
  final historicConfig = FlavorConfig(
      flavor: Flavor.historic,
      urlTemplate:
          'https://api.mapbox.com/styles/v1/charlie447/cleick6x9000d01qggtwy6rs2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hhcmxpZTQ0NyIsImEiOiJjbGVmcGhmZDcwdDc4M29tanRnOG5hbHUwIn0.gR8hNxBIUFLabHFrGfOYTw');
  // Inject our own configurations

  mainCommon(historicConfig);
}
