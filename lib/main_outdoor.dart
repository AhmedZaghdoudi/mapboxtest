import 'flavor_config.dart';
import 'main_comman.dart';

void main() {
  final outdoorConfig = FlavorConfig(
      flavor: Flavor.outdoor,
      urlTemplate:
          'https://api.mapbox.com/styles/v1/charlie447/clefqm9tr001h01po43fhu8zh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hhcmxpZTQ0NyIsImEiOiJjbGVmcGhmZDcwdDc4M29tanRnOG5hbHUwIn0.gR8hNxBIUFLabHFrGfOYTw');
  // Inject our own configurations

  mainCommon(outdoorConfig);
}
