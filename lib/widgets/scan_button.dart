import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:barcode_scan2/barcode_scan2.dart';

import 'package:qrreader/providers/db_providers.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_providers.dart';
import 'package:qrreader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    return FloatingActionButton(
      elevation: 3,
      child: const Icon(Icons.qr_code_scanner_rounded),

      onPressed: () async {
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        
        var barcodeRes = await BarcodeScanner.scan(
          options: const ScanOptions(
            useCamera: -1,
            autoEnableFlash: false,
            android: AndroidOptions(
              aspectTolerance: 0.00,
              useAutoFocus: true,
            ),
          ),
        );

        if (!barcodeRes.rawContent.contains('http') && !barcodeRes.rawContent.contains('geo')) {
          if (barcodeRes.rawContent != '') {
              await scanListProvider.nuevoScan(barcodeRes.rawContent);
              uiProvider.selectedMenuOpt = 2;
          }
          return;
        }

        final ScanModel scan = await scanListProvider.nuevoScan(barcodeRes.rawContent);
        launchUrlString(context, scan);
      },
    );
  }
}
