import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qrreader/providers/db_providers.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 25);

    Set<Marker> markers = <Marker>{};

    markers.add(Marker(
      markerId: const MarkerId('centerPoint'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo map'),
        actions: [
          IconButton(
            onPressed: () async {
              final controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getLatLng(), zoom: 17.5, tilt: 25),
                ),
              );
            },
            icon: const Icon(Icons.my_location_rounded),
          ),
          IconButton(
            onPressed: () async {
              !await launchUrl(
                Uri.parse(
                    'https://maps.google.com/?q=${scan.getLatLng().latitude},${scan.getLatLng().longitude}'),
                mode: LaunchMode.externalNonBrowserApplication,
              );
            },
            icon: const Icon(Icons.open_in_browser_rounded),
          ),
        ],
      ),
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          zoomControlsEnabled: false,
          compassEnabled: false,
          initialCameraPosition: puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Material(
            color: Colors.transparent,
            elevation: 1,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Location: ${scan.valor.replaceAll('geo:', '').replaceAll(',', ', ')}',
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                    ),
                    const Divider(),
                    Text(
                      'Google maps service. ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  color: Theme.of(context).colorScheme.surface,
                )))
      ]),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 6.5),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Share.share(
              'Check this https://maps.google.com/?q=${scan.getLatLng().latitude},${scan.getLatLng().longitude}',
            );
          },
          icon: const Icon(Icons.share_rounded),
          label: const Text('Share'),
        ),
      ),
    );
  }
}
