import 'package:flutter/material.dart';
import 'package:qrreader/widgets/scan_tiles.dart';

class WebsPage extends StatelessWidget {
  const WebsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}
