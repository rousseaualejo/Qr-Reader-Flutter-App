import 'package:flutter/material.dart';
import 'package:qrreader/widgets/scan_tiles.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'map');
  }
}
