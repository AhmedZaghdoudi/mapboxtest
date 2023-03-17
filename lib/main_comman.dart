import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:mapboxtest/flavor_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

var flavorConfigProvider;
final showCardProvider = StateProvider<bool>((ref) => false);
final cardContentProvider = StateProvider<String>((ref) => 'Card content');

void mainCommon(FlavorConfig config) {
  flavorConfigProvider = StateProvider((ref) => config);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(36.80464826880978, 10.169807754761157),
              zoom: 9.2,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    //(context.read(flavorConfigProvider).state.urlTemplate)
                    FlavorConfig.instance.urlTemplate,
                //  'https://api.mapbox.com/styles/v1/charlie447/clefqm9tr001h01po43fhu8zh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hhcmxpZTQ0NyIsImEiOiJjbGVmcGhmZDcwdDc4M29tanRnOG5hbHUwIn0.gR8hNxBIUFLabHFrGfOYTw',
                //https://api.mapbox.com/styles/v1/charlie447/cleick6x9000d01qggtwy6rs2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hhcmxpZTQ0NyIsImEiOiJjbGVmcGhmZDcwdDc4M29tanRnOG5hbHUwIn0.gR8hNxBIUFLabHFrGfOYTw
                // ignore: prefer_const_literals_to_create_immutables
                additionalOptions: {
                  'accessToken': 'give the acess token from mapbox',
                  'id': 'give the map id from mapbox'
                },
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 90.0,
                    height: 90.0,
                    point: latLng.LatLng(36.79682090130627, 10.167493960312028),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                    ),
                  ),
                  Marker(
                    width: 90.0,
                    height: 90.0,
                    point:
                        latLng.LatLng(36.862704279880624, 10.330922040082351),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 210, 52, 17),
                    ),
                  ),
                  Marker(
                    width: 90.0,
                    height: 90.0,
                    point: latLng.LatLng(36.7972814669719, 10.171647534328757),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 210, 52, 17),
                    ),
                  ),
                ],
              )
            ],
          ),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('The Enchanted Nightingale'),
                  subtitle:
                      Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 180,
                    height: 150,
                    child: const Image(
                      image: NetworkImage('https://picsum.photos/200/300'),
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.play_circle),
                      onPressed: () {
                        AudioPlayer().play(
                          AssetSource('../assets/audio/my_audio.mp3'),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      /*Positioned(
          left: 0,
          right: 0,
          bottom: 2,
          height: MediaQuery.of(context).size.height * 0.3,
          child: PageView.builder(
            onPageChanged: (value) {},
            itemCount: 3,
            itemBuilder: (_, index) {
              const item = 1;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromARGB(255, 30, 29, 29),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        )*/
    );
  }
}
