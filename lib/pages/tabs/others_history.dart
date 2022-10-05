import 'package:flutter/material.dart';
import 'package:qrreader/widgets/scan_tiles.dart';

class OthersHistory extends StatelessWidget {
  const OthersHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'other');
  }
}