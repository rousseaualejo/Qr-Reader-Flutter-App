import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qrreader/pages/tabs/others_history.dart';
import 'package:qrreader/providers/scan_list_provider.dart';

import 'package:qrreader/providers/ui_providers.dart';

import 'package:qrreader/pages/tabs/web_history.dart';
import 'package:qrreader/pages/tabs/maps_history.dart';
import 'package:qrreader/widgets/custom_navigationbar.dart';

import 'package:qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Scan'),
        scrolledUnderElevation: 4.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _HomePageBody()),
        ],
      ),
      floatingActionButton: const ScanButton(),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    final uiProvider = Provider.of<UiProvider>(context);

    //Get selected index
    final currentIndex = uiProvider.selectedMenuOpt;

    //User ScanListProvider
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapsPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const WebsPage();
      case 2:
        scanListProvider.cargarScansPorTipo('other');
        return const OthersHistory();
      default:
        return const WebsPage();
    }
  }
}
