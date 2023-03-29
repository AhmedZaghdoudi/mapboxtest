import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:mapboxtest/flavor_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
    as loc;

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
  bool _isVisible = false;
  late Position _currentPosition;
  bool loader = true;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: loc.LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        loader = false;
        print(_currentPosition.latitude);
        print(_currentPosition.longitude);
      });
    }).catchError((e) {
      // print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (!loader)
        ? Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center:
                        latLng.LatLng(36.80464826880978, 10.169807754761157),
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
                      // ),
                      // CompassLayerOptions(
                      //   compassHeadingAlignment: Alignment.bottomRight,
                      //   compassMargin: EdgeInsets.only(bottom: 40, right: 20),
                    ),
                    MarkerLayer(markers: [
                      Marker(
                          width: 90.0,
                          height: 90.0,
                          point: latLng.LatLng(
                              36.79682090130627, 10.167493960312028),
                          builder: (ctx) => const Icon(
                                Icons.location_on,
                              )),
                      Marker(
                        width: 90.0,
                        height: 90.0,
                        point: latLng.LatLng(
                            36.862704279880624, 10.330922040082351),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 210, 52, 17),
                        ),
                      ),
                      Marker(
                        width: 90.0,
                        height: 90.0,
                        point:
                            latLng.LatLng(36.7972814669719, 10.171647534328757),
                        builder: (ctx) => IconButton(
                          icon: const Icon(Icons.location_on),
                          color: const Color.fromARGB(255, 210, 52, 17),
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                      ),
                      Marker(
                        width: 90.0,
                        height: 90.0,
                        point: latLng.LatLng(_currentPosition.latitude,
                            _currentPosition.longitude),
                        // _currentPosition.latitude, _currentPosition.longitude
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 41, 12, 185),
                        ),
                      ),
                    ]),
                    // FloatingActionButton(
                    //   onPressed: () {
                    //     context.read(userLocationProvider.future);
                    //   },
                    //   child: const Icon(Icons.location_searching),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 500),
                  child: Card(
                    elevation: 20.0,
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
                          subtitle: Text(
                              'Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 100,
                              height: 80,
                              child: const Image(
                                image: NetworkImage(
                                    'https://picsum.photos/200/300'),
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.cover,
                              )),
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
                                // AudioPlayer().play(
                                //     AssetSource('../assets/audio/my_audio.mp3'));
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child: Card(
                    elevation: 20.0,
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
                          subtitle: Text(
                              'Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 100,
                              height: 80,
                              child: const Image(
                                image: NetworkImage(
                                    'https://picsum.photos/200/300'),
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.cover,
                              )),
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
                                // AudioPlayer().play(
                                //     AssetSource('../assets/audio/my_audio.mp3'));
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
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
          )
        : const Center(child: CircularProgressIndicator());
  }

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: loc.LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       print(_currentPosition.latitude);
  //       print(_currentPosition.longitude);
  //     });
  //   }).catchError((e) {
  //     // print(e);
  //   });
  // }
}
